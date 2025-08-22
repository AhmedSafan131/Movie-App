// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = 'https://route-movie-apis.vercel.app';

  static Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
    required int avatarId,
  }) async {
    try {
      final requestBody = {
        'name': name,
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
        'phone': phone,
        'avaterId': avatarId, // Note: API uses 'avaterId' (typo in API)
      };

      print(
        'Sending registration request with body: ${jsonEncode(requestBody)}',
      );

      final response = await http.post(
        Uri.parse('$baseUrl/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        // Try to parse error response
        try {
          final errorResponse = jsonDecode(response.body);
          throw Exception(
            'Registration failed: ${errorResponse['message'] ?? 'Status ${response.statusCode}'}',
          );
        } catch (e) {
          throw Exception(
            'Registration failed: Status ${response.statusCode} - ${response.body}',
          );
        }
      }
    } catch (e) {
      if (e.toString().contains('Registration failed:')) {
        rethrow; // Re-throw API errors
      }
      throw Exception('Network error: $e');
    }
  }

  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Login failed: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  static Future<Map<String, dynamic>> forgetPassword({
    required String email,
  }) async {
    // Try multiple possible endpoints for forget password
    final List<String> possibleEndpoints = [
      '/auth/forgot-password',
      '/auth/forget-password',
      '/auth/reset-password-request',
      '/auth/password-reset',
      '/auth/send-reset-email',
      '/auth/request-password-reset',
      '/auth/send-password-reset',
      '/auth/forgot-password-request',
      '/auth/password-reset-request',
      '/auth/email-reset',
      '/auth/send-email-reset',
    ];

    for (String endpoint in possibleEndpoints) {
      try {
        print('Trying endpoint: $baseUrl$endpoint');
        final response = await http.post(
          Uri.parse('$baseUrl$endpoint'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'email': email}),
        );

        print('Response status for $endpoint: ${response.statusCode}');
        print('Response body for $endpoint: ${response.body}');

        if (response.statusCode == 200 || response.statusCode == 201) {
          print('Success with endpoint: $endpoint');
          return jsonDecode(response.body);
        } else if (response.statusCode == 404) {
          print('404 for endpoint: $endpoint, trying next...');
          // Continue to next endpoint if this one returns 404
          continue;
        } else {
          // Try to parse error response
          try {
            final errorResponse = jsonDecode(response.body);
            throw Exception(
              'Forget password failed: ${errorResponse['message'] ?? 'Status ${response.statusCode}'}',
            );
          } catch (e) {
            throw Exception(
              'Forget password failed: Status ${response.statusCode} - ${response.body}',
            );
          }
        }
      } catch (e) {
        if (e.toString().contains('Forget password failed:')) {
          rethrow; // Re-throw API errors
        }
        print('Error with endpoint $endpoint: $e');
        // Continue to next endpoint if this one fails
        continue;
      }
    }

    // If all endpoints fail, throw a generic error with helpful information
    throw Exception(
      'Forget password failed: No valid endpoint found. The API might not support automatic password reset emails. Please contact support or use the manual password reset feature.',
    );
  }
}
