import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_style.dart';
import '../../../utils/app_routes.dart';
import '../../../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Form controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Form key for validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Loading state
  bool _isLoading = false;

  // Password visibility state
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await AuthService.login(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response['message'] ?? 'Login successful!'),
            backgroundColor: AppColors.successGreen,
          ),
        );

        // Navigate to home screen
        Navigator.of(context).pushReplacementNamed(AppRoutes.home);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login failed: ${e.toString()}'),
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
                  child: Container(
                    width: 180,
                    height: 180,
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        // Fallback to play button if image is not found
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

                // Input Fields
                TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  style: AppTextStyles.body.copyWith(color: AppColors.white),
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: AppTextStyles.body
                        .copyWith(color: AppColors.white.withOpacity(0.7)),
                    prefixIcon: const Icon(Icons.email, color: AppColors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.darkGray),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(color: AppColors.accentYellow),
                    ),
                    filled: true,
                    fillColor: AppColors.darkGray,
                  ),
                ),

                const SizedBox(height: 16),

                TextFormField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    return null;
                  },
                  style: AppTextStyles.body.copyWith(color: AppColors.white),
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: AppTextStyles.body
                        .copyWith(color: AppColors.white.withOpacity(0.7)),
                    prefixIcon: const Icon(Icons.lock, color: AppColors.white),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: AppColors.white,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.darkGray),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(color: AppColors.accentYellow),
                    ),
                    filled: true,
                    fillColor: AppColors.darkGray,
                  ),
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
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.accentYellow,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Login button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accentYellow,
                      foregroundColor: AppColors.primaryBlack,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColors.primaryBlack),
                            ),
                          )
                        : Text(
                            'Login',
                            style: AppTextStyles.button.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 20),

                // Create account link
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.white,
                        fontSize: 14,
                      ),
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
                              Navigator.of(context)
                                  .pushNamed(AppRoutes.register);
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
                      child: Text(
                        'OR',
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.accentYellow,
                          fontSize: 14,
                        ),
                      ),
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
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Handle Google login
                    },
                    icon: Image.asset(
                      'assets/images/google.png',
                      width: 24,
                      height: 24,
                      errorBuilder: (context, error, stackTrace) {
                        // Fallback to icon if image is not found
                        return const Icon(
                          Icons.g_mobiledata,
                          color: AppColors.primaryBlack,
                          size: 24,
                        );
                      },
                    ),
                    label: Text(
                      'Login With Google',
                      style: AppTextStyles.button.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accentYellow,
                      foregroundColor: AppColors.primaryBlack,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
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
