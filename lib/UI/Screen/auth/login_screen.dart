import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/UI/widgets/auth_navigator.dart';
import 'package:movie_app/UI/widgets/custom_button.dart';
import 'package:movie_app/UI/widgets/custom_snack_bar.dart';
import 'package:movie_app/UI/widgets/custom_text_field.dart';
import 'package:movie_app/blocs/auth_cubit/login/login_state.dart';
import 'package:movie_app/blocs/auth_cubit/login/login_view_model.dart';

import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/app_routes.dart';
import 'package:movie_app/utils/app_styles.dart';
import 'package:movie_app/utils/assets_manager.dart';
import 'package:movie_app/utils/validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Form controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late LoginViewModel viewModel;

  // Form key for validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Password visibility state
  bool _isPasswordVisible = false;
  @override
  void initState() {
    super.initState();
    viewModel = LoginViewModel();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      viewModel.login(
          email: _emailController.text, password: _passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginViewModel, LoginState>(
         bloc: viewModel,
        listener: (context, state) {
          if (state is LoginSuccess) {
            CustomSnackBar.show(context,
                message: 'Login successful!', isError: false);
            Navigator.of(context).pushReplacementNamed(AppRoutes.home);
          } else if (state is LoginFailure) {
            CustomSnackBar.show(context,
                message: 'Login failed: ${state.message}', isError: true);
          }
        },
        child: BlocBuilder<LoginViewModel, LoginState>(
          bloc: viewModel,
          builder: (context, state) {
            return SafeArea(
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
                            AssetsManager.logo,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              // Fallback to play button if image is not found
                              return Container(
                                decoration: const BoxDecoration(
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
                        prefixIcon:
                            const Icon(Icons.email, color: AppColors.white),
                        validator: (value) => Validator.emailValidator(value),
                      ),

                      const SizedBox(height: 16),

                      // Password Field
                      CustomTextField(
                        controller: _passwordController,
                        hintText: 'Password',
                        obscureText: !_isPasswordVisible,
                        prefixIcon:
                            const Icon(Icons.lock, color: AppColors.white),
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
                        validator: (value) =>
                            Validator.passwordValidator(value),
                      ),

                      // Forget Password
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(AppRoutes.forgetPassword);
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
                        isLoading: state is LoginLoading,
                      ),

                      const SizedBox(height: 20),

                      // Create account link
                      AuthNavigator(
                        lineText: "Don't Have Account ? ",
                        buttonText: 'Create One',
                        onTap: () =>
                            Navigator.of(context).pushNamed(AppRoutes.register),
                      ),
                      // Center(
                      //   child: RichText(
                      //     text: TextSpan(
                      //       style: AppStyles.medium14White,
                      //       children: [
                      //         const TextSpan(text: ""),
                      //         TextSpan(
                      //           text: 'Create One',
                      //           style: const TextStyle(
                      //             color: AppColors.accentYellow,
                      //             fontWeight: FontWeight.w600,
                      //           ),
                      //           recognizer: TapGestureRecognizer()
                      //             ..onTap = () {
                      //               Navigator.of(
                      //                 context,
                      //               ).pushNamed(AppRoutes.register);
                      //             },
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),

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
                          AssetsManager.google,
                          // width: 24,
                          // height: 24,
                          errorBuilder: (context, error, stackTrace) {
                            // Fallback to icon if image is not found
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
            );
          },
        ),
      ),
    );
  }
}
