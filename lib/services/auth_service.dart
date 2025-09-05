// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String baseUrl = 'https://route-movie-apis.vercel.app';
  static const String _tokenKey = 'auth_token';

  // Token management methods
  static Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  static Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  static Future<void> _clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  // Public methods for token management
  static Future<bool> isLoggedIn() async {
    final token = await _getToken();
    return token != null;
  }

  static Future<String?> getCurrentToken() async {
    return await _getToken();
  }

  static Future<void> logout() async {
    await _clearToken();
  }

  // For testing purposes - manually set a token
  static Future<void> setTokenForTesting(String token) async {
    await _saveToken(token);
    print('Test token set: $token');
  }

  static Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
    required String avatarId,
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
        final data = jsonDecode(response.body);
        print('Login response: ${jsonEncode(data)}');
        print('Login response keys: ${data.keys.toList()}');

        // Try different possible token field names
        final token =
            data['token'] ??
            data['accessToken'] ??
            data['access_token'] ??
            data['jwt'] ??
            data['access_token'] ??
            data['authToken'] ??
            data['auth_token'];
        if (token != null) {
          await _saveToken(token);
          print('Token saved successfully: ${token.substring(0, 20)}...');
        } else {
          print(
            'Warning: No token found in login response. Available fields: ${data.keys.toList()}',
          );
        }
        return data;
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

  static Future<Map<String, dynamic>> resetPassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final token = await _getToken();
      if (token == null) {
        throw Exception('No authentication token found. Please login first.');
      }

      final requestBody = {
        'oldPassword': oldPassword,
        'newPassword': newPassword,
      };

      print(
        'Sending reset password request with body: ${jsonEncode(requestBody)}',
      );

      final response = await http.patch(
        Uri.parse('$baseUrl/auth/reset-password'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(requestBody),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        // Try to parse response body if it exists
        if (response.body.isNotEmpty) {
          return jsonDecode(response.body);
        } else {
          // Return success message if no response body
          return {'message': 'Password reset successfully!'};
        }
      } else if (response.statusCode == 401) {
        // Token is invalid or expired
        await _clearToken(); // Clear the invalid token
        throw Exception(
          'Authentication failed. Your session has expired. Please login again.',
        );
      } else {
        // Try to parse error response
        try {
          final errorResponse = jsonDecode(response.body);
          throw Exception(
            'Reset password failed: ${errorResponse['message'] ?? 'Status ${response.statusCode}'}',
          );
        } catch (e) {
          throw Exception(
            'Reset password failed: Status ${response.statusCode} - ${response.body}',
          );
        }
      }
    } catch (e) {
      if (e.toString().contains('Reset password failed:')) {
        rethrow; // Re-throw API errors
      }
      throw Exception('Network error: $e');
    }
  }
}
