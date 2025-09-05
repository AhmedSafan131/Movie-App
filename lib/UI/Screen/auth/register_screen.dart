import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/UI/widgets/avatar_picer.dart';
import 'package:movie_app/UI/widgets/custom_button.dart';
import 'package:movie_app/UI/widgets/custom_snack_bar.dart';
import 'package:movie_app/UI/widgets/custom_text_field.dart';
import 'package:movie_app/UI/widgets/auth_navigator.dart';
import 'package:movie_app/blocs/auth_cubit/register/register_view_model.dart';
import 'package:movie_app/blocs/auth_cubit/register/resgister_state.dart';
import 'package:movie_app/l10n/app_localizations.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/app_routes.dart';
import 'package:movie_app/utils/app_styles.dart';
import 'package:movie_app/utils/validator.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late RegisterViewModel viewModel;
  late PageController pageController;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  @override
  void initState() {
    super.initState();
    viewModel = RegisterViewModel();
    pageController = PageController(viewportFraction: 0.3);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.register,
          style: AppStyles.medium18Yellow,
        ),
        centerTitle: true,
      ),
      body: BlocListener<RegisterViewModel, RegisterState>(
        bloc: viewModel,
        listener: (context, state) {
          if (state is RegisterSuccess) {
            CustomSnackBar.show(context,
                message: 'Registration successful!', isError: false);
            Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.home,(route) => false,);
          } else if (state is RegisterFailure) {
            CustomSnackBar.show(context,
                message: 'Registration failed: ${state.message}',
                isError: true);
          }
        },
        child: BlocBuilder<RegisterViewModel, RegisterState>(
          bloc: viewModel,
          builder: (context, state) {
            return SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      AvatarPicker(
                          pageController: pageController,
                          selectedAvatar: viewModel.selectedAvatar,
                          onAvatarSelected: viewModel.setAvatar),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Text(
                        'Avatar',
                        style: AppStyles.medium16White,
                      ),
                      // Name Field
                      CustomTextField(
                        controller: _nameController,
                        hintText: 'Name',
                        prefixIcon:
                            const Icon(Icons.person, color: AppColors.white),
                        validator: (value) => Validator.nameValidator(value),
                      ),
                      const SizedBox(height: 16),
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
                      const SizedBox(height: 16),
                      // Confirm Password Field
                      CustomTextField(
                        controller: _confirmPasswordController,
                        hintText: 'Confirm Password',
                        obscureText: !_isConfirmPasswordVisible,
                        prefixIcon:
                            const Icon(Icons.lock, color: AppColors.white),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isConfirmPasswordVisible =
                                  !_isConfirmPasswordVisible;
                            });
                          },
                          icon: Icon(
                            _isConfirmPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColors.white,
                          ),
                        ),
                        validator: (value) =>
                            Validator.confirmPasswordValidator(
                                value, _passwordController.text),
                      ),
                      const SizedBox(height: 16),
                      // Phone Field
                      CustomTextField(
                        controller: _phoneController,
                        hintText: 'Phone Number',
                        keyboardType: TextInputType.phone,
                        prefixIcon:
                            const Icon(Icons.phone, color: AppColors.white),
                        validator: (value) => Validator.phoneValidator(value),
                      ),
                      const SizedBox(height: 32),
                      CustomButton(
                        text: 'Create Account',
                        isLoading: state is RegisterLoading,
                        onPressed: registerOnPressed,
                      ),
                      const SizedBox(height: 32),
                      // Login link
                      AuthNavigator(
                        lineText: 'Already Have Account ?',
                        buttonText: 'Login',
                        onTap: () => Navigator.of(context).pop(),
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

  void registerOnPressed() {
    if (_formKey.currentState!.validate()) {
      viewModel.register(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        confirmPassword: _confirmPasswordController.text,
        phone: '+2${_phoneController.text}',
        avaterId: viewModel.selectedAvatar,
      );
    }
  }
}
