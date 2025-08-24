import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class UserRepository {
  static const String _userKey = 'user_data';

  // Save user data to SharedPreferences
  Future<void> saveUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = jsonEncode(user.toJson());

    print('=== SAVING USER DATA ===');
    print('Saving user: $user');
    print('User JSON: $userJson');

    await prefs.setString(_userKey, userJson);

    // Verify the save
    final savedJson = prefs.getString(_userKey);
    print('Verified saved data: $savedJson');

    // Additional verification
    final allKeys = prefs.getKeys();
    print('All SharedPreferences keys: $allKeys');
    print('=== SAVE COMPLETE ===');
  }

  // Load user data from SharedPreferences
  Future<UserModel?> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_userKey);

    print('=== LOADING USER DATA ===');
    print('User JSON from SharedPreferences: $userJson');

    // Additional debugging
    final allKeys = prefs.getKeys();
    print('All SharedPreferences keys: $allKeys');

    if (userJson != null) {
      try {
        final userMap = jsonDecode(userJson) as Map<String, dynamic>;
        print('Parsed user map: $userMap');
        final user = UserModel.fromJson(userMap);
        print('Successfully loaded user: $user');
        return user;
      } catch (e) {
        print('Error parsing user data: $e');
        return null;
      }
    } else {
      print('No user data found in SharedPreferences');
    }
    return null;
  }

  // Clear user data from SharedPreferences
  Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
    print('=== CLEARED USER DATA ===');
    print('User data cleared from SharedPreferences');
  }

  // Debug method to clear all SharedPreferences data
  Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    print('=== CLEARED ALL SHAREDPREFERENCES DATA ===');
  }

  // Debug method to print all SharedPreferences data
  Future<void> debugPrintAllData() async {
    final prefs = await SharedPreferences.getInstance();
    final allKeys = prefs.getKeys();
    print('=== ALL SHAREDPREFERENCES DATA ===');
    print('Keys: $allKeys');
    for (final key in allKeys) {
      final value = prefs.get(key);
      print('$key: $value');
    }
    print('=== END SHAREDPREFERENCES DATA ===');
  }

  // Update specific user field
  Future<void> updateUserField(String field, String value) async {
    final currentUser = await loadUser();
    if (currentUser != null) {
      UserModel updatedUser;

      switch (field) {
        case 'name':
          updatedUser = currentUser.copyWith(name: value);
          break;
        case 'phone':
          updatedUser = currentUser.copyWith(phone: value);
          break;
        case 'avatar':
          updatedUser = currentUser.copyWith(avatar: value);
          break;
        default:
          return;
      }

      await saveUser(updatedUser);
    }
  }
}
