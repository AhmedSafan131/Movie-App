import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/app_styles.dart';
import '../../utils/app_routes.dart';
import '../../services/auth_service.dart';
import '../../UI/widgets/custom_text_field.dart';
import '../../UI/widgets/custom_button.dart';
import '../../UI/widgets/auth/auth_header.dart';
import '../../UI/widgets/auth/password_field.dart';
import '../../UI/widgets/auth/avatar_selector.dart';
import '../../utils/auth_validators.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  int selectedAvatar = 0;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final response = await AuthService.register(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
        confirmPassword: _confirmPasswordController.text,
        phone: _phoneController.text.trim(),
        avatarId: selectedAvatar + 1,
      );

      if (mounted) {
        _showSuccessSnackBar(response['message'] ?? 'Registration successful!');
        Navigator.of(context).pushReplacementNamed(AppRoutes.login);
      }
    } catch (e) {
      _showErrorSnackBar('Registration failed: ${e.toString()}');
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

  Color _getAvatarColor(int index) {
    switch (index) {
      case 0:
        return Colors.green;
      case 1:
        return Colors.red;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.blue;
      case 4:
        return Colors.purple;
      case 5:
        return Colors.pink;
      case 6:
        return Colors.teal;
      case 7:
        return Colors.indigo;
      case 8:
        return Colors.amber;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlack,
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
                          'Register',
                          style: AppStyles.medium18Yellow,
                        ),
                      ),
                    ),
                    const SizedBox(width: 48), // Balance the header
                  ],
                ),

                const SizedBox(height: 16),

                // Avatar Selection
                Center(
                  child: Column(
                    children: [
                      // Horizontal Scrollable Avatar List with Selected Larger
                      SizedBox(
                        height: 100,
                        width: double.infinity,
                        child: PageView.builder(
                          itemCount: 9,
                          controller: PageController(
                            initialPage: selectedAvatar,
                            viewportFraction: 0.3,
                          ),
                          onPageChanged: (index) {
                            setState(() {
                              selectedAvatar = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            bool isSelected = selectedAvatar == index;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedAvatar = index;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                width: isSelected ? 50 : 80,
                                height: isSelected ? 50 : 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected
                                        ? AppColors.accentYellow
                                        : Colors.transparent,
                                    width: isSelected ? 4 : 0,
                                  ),
                                ),
                                child: ClipOval(
                                  child: Image.asset(
                                    'assets/images/avatar${index + 1}.png',
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          color: _getAvatarColor(index),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.person,
                                          color: AppColors.white,
                                          size: isSelected ? 40 : 25,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text('Avatar', style: AppStyles.medium16White),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Name Field
                CustomTextField(
                  controller: _nameController,
                  hintText: 'Name',
                  prefixIcon: const Icon(Icons.person, color: AppColors.white),
                  validator: AuthValidators.validateName,
                ),

                const SizedBox(height: 16),

                // Email Field
                CustomTextField(
                  controller: _emailController,
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.email, color: AppColors.white),
                  validator: AuthValidators.validateEmail,
                ),

                const SizedBox(height: 16),

                // Password Field
                PasswordField(
                  controller: _passwordController,
                  hintText: 'Password',
                  validator: AuthValidators.validatePassword,
                ),

                const SizedBox(height: 16),

                // Confirm Password Field
                PasswordField(
                  controller: _confirmPasswordController,
                  hintText: 'Confirm Password',
                  validator: (value) => AuthValidators.validateConfirmPassword(
                    value,
                    _passwordController.text,
                  ),
                ),

                const SizedBox(height: 16),

                // Phone Field
                CustomTextField(
                  controller: _phoneController,
                  hintText: 'Phone Number',
                  keyboardType: TextInputType.phone,
                  prefixIcon: const Icon(Icons.phone, color: AppColors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Phone number is required';
                    }
                    final cleanPhone = value.replaceAll(RegExp(r'[^\d]'), '');
                    if (cleanPhone.length < 10) {
                      return 'Please enter a valid phone number';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 32),

                // Create Account button
                CustomButton(
                  text: 'Create Account',
                  onPressed: _register,
                  isLoading: _isLoading,
                ),

                const SizedBox(height: 32),

                // Login link
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: AppStyles.medium14White,
                      children: [
                        const TextSpan(text: 'Already Have Account ? '),
                        TextSpan(
                          text: 'Login',
                          style: TextStyle(
                            color: AppColors.accentYellow,
                            fontWeight: FontWeight.w600,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).pop();
                            },
                        ),
                      ],
                    ),
                  ),
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
