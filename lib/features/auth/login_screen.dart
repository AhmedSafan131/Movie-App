import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/app_styles.dart';
import '../../utils/app_routes.dart';
import '../../services/auth_service.dart';
import '../../UI/widgets/custom_text_field.dart';
import '../../UI/widgets/custom_button.dart';
import '../../UI/widgets/auth/auth_header.dart';
import '../../UI/widgets/auth/password_field.dart';
import '../../UI/widgets/auth/auth_form.dart';
import '../../utils/auth_validators.dart';
import '../../blocs/user/user_bloc.dart';
import '../../blocs/user/user_event.dart';
import '../../models/user_model.dart';
import '../../repositories/user_repository.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final response = await AuthService.login(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      await _handleLoginSuccess(response);
    } catch (e) {
      _showErrorSnackBar('Login failed: ${e.toString()}');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _handleLoginSuccess(Map<String, dynamic> response) async {
    final userRepository = UserRepository();
    final existingUser = await userRepository.loadUser();

    UserModel user;
    if (existingUser != null) {
      user = existingUser.copyWith(email: _emailController.text.trim());
      print('Login: Preserving existing user data: $user');
    } else {
      user = UserModel(
        name: response['user']?['name'] ?? 'User',
        phone: response['user']?['phone'] ?? '',
        avatar: response['user']?['avatar'] ?? 'assets/images/avatar1.png',
        email: _emailController.text.trim(),
      );
      print('Login: Creating new user from API response: $user');
    }

    if (mounted) {
      context.read<UserBloc>().add(UpdateUser(user));
      _showSuccessSnackBar(response['message'] ?? 'Login successful!');
      Navigator.of(context).pushReplacementNamed(AppRoutes.home);
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
      backgroundColor: AppColors.primaryBlack,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo
                Center(
                  child: SizedBox(
                    width: 180,
                    height: 180,
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          decoration: BoxDecoration(
                            color: AppColors.accentYellow,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.play_arrow,
                            size: 40,
                            color: AppColors.primaryBlack,
                          ),
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 20),

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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    return null;
                  },
                ),

                // Forget Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoutes.forgetPassword);
                    },
                    child: Text(
                      'Forget Password ?',
                      style: AppStyles.medium14Yellow,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Login button
                CustomButton(
                  text: 'Login',
                  onPressed: _login,
                  isLoading: _isLoading,
                ),

                const SizedBox(height: 20),

                // Create account link
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: AppStyles.medium14White,
                      children: [
                        const TextSpan(text: "Don't Have Account ? "),
                        TextSpan(
                          text: 'Create One',
                          style: TextStyle(
                            color: AppColors.accentYellow,
                            fontWeight: FontWeight.w600,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(
                                context,
                              ).pushNamed(AppRoutes.register);
                            },
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // OR divider
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        color: AppColors.accentYellow,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text('OR', style: AppStyles.medium14Yellow),
                    ),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: AppColors.accentYellow,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Google login button
                CustomButton(
                  text: 'Login With Google',
                  onPressed: () {
                    // Handle Google login
                  },
                  icon: Image.asset(
                    'assets/images/google.png',
                    width: 24,
                    height: 24,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.g_mobiledata,
                        color: AppColors.primaryBlack,
                        size: 24,
                      );
                    },
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
