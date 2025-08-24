import 'package:flutter/material.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/app_styles.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_button.dart';
import '../../../services/auth_service.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  // Form controllers
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // Form key for validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Loading state
  bool _isLoading = false;

  // Password visibility states
  bool _isOldPasswordVisible = false;
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _resetPassword() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await AuthService.resetPassword(
        oldPassword: _oldPasswordController.text.trim(),
        newPassword: _newPasswordController.text.trim(),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              response['message'] ?? 'Password reset successfully!',
              style: AppStyles.medium16White,
            ),
            backgroundColor: AppColors.successGreen,
          ),
        );

        // Clear all fields
        _oldPasswordController.clear();
        _newPasswordController.clear();
        _confirmPasswordController.clear();

        // Navigate back
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to reset password: ${e.toString()}',
              style: AppStyles.medium16White,
            ),
            backgroundColor: AppColors.errorRed,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with back button
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(
                        Icons.arrow_back,
                        color: AppColors.accentYellow,
                        size: 24,
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'Reset Password',
                          style: AppStyles.medium16Yellow,
                        ),
                      ),
                    ),
                    const SizedBox(width: 48), // Balance the header
                  ],
                ),

                const SizedBox(height: 40),

                // Title
                Text('Reset Your Password', style: AppStyles.medium24White),

                const SizedBox(height: 8),

                // Subtitle
                Text(
                  'Enter your old password and create a new one with confirmation',
                  style: AppStyles.medium16White,
                ),

                const SizedBox(height: 32),

                // Old Password input field
                CustomTextField(
                  controller: _oldPasswordController,
                  hintText: 'Enter your old password',
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: !_isOldPasswordVisible,
                  prefixIcon: const Icon(Icons.lock, color: AppColors.white),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isOldPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: AppColors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        _isOldPasswordVisible = !_isOldPasswordVisible;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Old password is required';
                    }
                    if (value.length < 6) {
                      return 'Old password must be at least 6 characters';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // New Password input field
                CustomTextField(
                  controller: _newPasswordController,
                  hintText: 'Enter your new password',
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: !_isNewPasswordVisible,
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: AppColors.white,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isNewPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: AppColors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        _isNewPasswordVisible = !_isNewPasswordVisible;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'New password is required';
                    }
                    if (value.length < 8) {
                      return 'Password must be at least 8 characters';
                    }
                    // Password strength validation
                    if (!RegExp(
                      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]',
                    ).hasMatch(value)) {
                      return 'Password must contain uppercase, lowercase, number, and special character';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // Confirm New Password input field
                CustomTextField(
                  controller: _confirmPasswordController,
                  hintText: 'Confirm your new password',
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: !_isConfirmPasswordVisible,
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: AppColors.white,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isConfirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: AppColors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _newPasswordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 32),

                // Debug: Check current token
                CustomButton(
                  text: 'Debug: Check Token',
                  onPressed: () async {
                    final token = await AuthService.getCurrentToken();
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Current token: ${token ?? 'NO TOKEN'}',
                            style: AppStyles.medium16White,
                          ),
                          backgroundColor: token != null
                              ? AppColors.successGreen
                              : AppColors.errorRed,
                        ),
                      );
                    }
                  },
                  backgroundColor: AppColors.accentYellow,
                  textColor: AppColors.primaryBlack,
                ),

                const SizedBox(height: 8),

                // Debug: Set test token from API docs
                CustomButton(
                  text: 'Debug: Set Test Token',
                  onPressed: () async {
                    const testToken =
                        'eyJhbGciOiJIUzI1NilsInR5cCI6IkpXVCJ9.eyJpZCI6IjY3NDFkMGFkODZIM2ZmZmIwM2IzO GEWOCIsImVtYWIsIjoiYW1yMjRAZ21haWwuY29tliwiaWF0ljoxNzMyMzY4MDQ1fQ.vhf0NB Qzj8EE9AinCX3ezu4yz1R8CNpt8xBawnTyMhw';
                    await AuthService.setTokenForTesting(testToken);
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Test token set successfully!',
                            style: AppStyles.medium16White,
                          ),
                          backgroundColor: AppColors.successGreen,
                        ),
                      );
                    }
                  },
                  backgroundColor: AppColors.primaryBlack,
                  textColor: AppColors.accentYellow,
                ),

                const SizedBox(height: 16),

                // Reset Password button
                CustomButton(
                  text: 'Reset Password',
                  onPressed: _resetPassword,
                  isLoading: _isLoading,
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
