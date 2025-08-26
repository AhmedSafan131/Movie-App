import 'package:flutter/material.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/app_styles.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/auth/password_field.dart';
import '../../../services/auth_service.dart';
import '../../../utils/auth_validators.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _resetPassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final response = await AuthService.resetPassword(
        oldPassword: _oldPasswordController.text.trim(),
        newPassword: _newPasswordController.text.trim(),
      );

      if (mounted) {
        _showSuccessSnackBar(
          response['message'] ?? 'Password reset successfully!',
        );
        _clearFields();
        Navigator.of(context).pop();
      }
    } catch (e) {
      _showErrorSnackBar('Failed to reset password: ${e.toString()}');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _clearFields() {
    _oldPasswordController.clear();
    _newPasswordController.clear();
    _confirmPasswordController.clear();
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: AppColors.successGreen),
    );
  }

  void _showErrorSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: AppColors.errorRed),
      );
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
                PasswordField(
                  controller: _oldPasswordController,
                  hintText: 'Enter your old password',
                  validator: AuthValidators.validateOldPassword,
                ),

                const SizedBox(height: 20),

                // New Password input field
                PasswordField(
                  controller: _newPasswordController,
                  hintText: 'Enter your new password',
                  validator: AuthValidators.validatePassword,
                ),

                const SizedBox(height: 20),

                // Confirm New Password input field
                PasswordField(
                  controller: _confirmPasswordController,
                  hintText: 'Confirm your new password',
                  validator: (value) => AuthValidators.validateConfirmPassword(
                    value,
                    _newPasswordController.text,
                  ),
                ),

                const SizedBox(height: 32),

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
