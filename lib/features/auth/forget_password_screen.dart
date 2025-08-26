import 'package:flutter/material.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/app_styles.dart';
import '../../services/auth_service.dart';
import '../../UI/widgets/custom_text_field.dart';
import '../../UI/widgets/custom_button.dart';
import '../../utils/auth_validators.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _sendResetEmail() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final response = await AuthService.forgetPassword(
        email: _emailController.text.trim(),
      );

      if (mounted) {
        _showSuccessSnackBar(
          response['message'] ?? 'Reset email sent successfully!',
        );
        _emailController.clear();
      }
    } catch (e) {
      _showErrorSnackBar('Failed to send reset email: ${e.toString()}');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
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
                          'Forget Password',
                          style: AppStyles.medium16Yellow,
                        ),
                      ),
                    ),
                    const SizedBox(width: 48), // Balance the header
                  ],
                ),

                const SizedBox(height: 40),

                // Illustration
                Center(
                  child: SizedBox(
                    width: 300,
                    height: 250,
                    child: Image.asset(
                      'assets/images/forgot_password.png',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            color: AppColors.primaryBlack,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Stack(
                            children: [
                              // Woman figure
                              Positioned(
                                bottom: 20,
                                left: 50,
                                child: Container(
                                  width: 60,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: AppColors.accentYellow,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: const Icon(
                                    Icons.person,
                                    color: AppColors.primaryBlack,
                                    size: 40,
                                  ),
                                ),
                              ),
                              // Laptop
                              Positioned(
                                bottom: 40,
                                left: 30,
                                child: Container(
                                  width: 40,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    color: AppColors.darkGray,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ),
                              // Password card with X
                              Positioned(
                                top: 30,
                                right: 30,
                                child: Container(
                                  width: 80,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: AppColors.accentYellow,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.close,
                                        color: AppColors.primaryBlack,
                                        size: 20,
                                      ),
                                      const SizedBox(height: 4),
                                      Container(
                                        width: 50,
                                        height: 8,
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryBlack,
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // Plant elements
                              Positioned(
                                top: 60,
                                right: 10,
                                child: Container(
                                  width: 20,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // Title
                Text('Forgot Your Password?', style: AppStyles.medium24White),

                const SizedBox(height: 8),

                // Subtitle
                Text(
                  'Enter your email address and we\'ll send you a link to reset your password',
                  style: AppStyles.medium16White,
                ),

                const SizedBox(height: 32),

                // Email input field
                CustomTextField(
                  controller: _emailController,
                  hintText: 'Enter your email address',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.email, color: AppColors.white),
                  validator: AuthValidators.validateEmail,
                ),

                const SizedBox(height: 26),

                // Send Reset Email button
                CustomButton(
                  text: 'Verify Email',
                  onPressed: _sendResetEmail,
                  isLoading: _isLoading,
                ),

                const SizedBox(height: 20),

                // Back to login link
              ],
            ),
          ),
        ),
      ),
    );
  }
}
