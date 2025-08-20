import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_style.dart';
import '../../../utils/app_routes.dart';
import '../../../services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  int selectedAvatar = 0;

  // Form controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  // Form key for validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Loading state
  bool _isLoading = false;

  // Password visibility states
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

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
                          style: AppTextStyles.h2.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: AppColors.accentYellow,
                          ),
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
                      Container(
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
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
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
                                      // Fallback to colored circle if image is not found
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
                      Text(
                        'Avatar',
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Input Fields
                TextFormField(
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                  style: AppTextStyles.body.copyWith(color: AppColors.white),
                  decoration: InputDecoration(
                    hintText: 'Name',
                    hintStyle: AppTextStyles.body
                        .copyWith(color: AppColors.white.withOpacity(0.7)),
                    prefixIcon:
                        const Icon(Icons.person, color: AppColors.white),
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
                    if (value.length < 8) {
                      return 'Password must be at least 8 characters';
                    }
                    // Check for strong password requirements
                    if (!RegExp(
                            r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]')
                        .hasMatch(value)) {
                      return 'Password must contain uppercase, lowercase, number, and special character';
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

                const SizedBox(height: 16),

                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: !_isConfirmPasswordVisible,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Confirm password is required';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  style: AppTextStyles.body.copyWith(color: AppColors.white),
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    hintStyle: AppTextStyles.body
                        .copyWith(color: AppColors.white.withOpacity(0.7)),
                    prefixIcon: const Icon(Icons.lock, color: AppColors.white),
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
                  controller: _phoneController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Phone number is required';
                    }
                    // Remove any non-digit characters for validation
                    final cleanPhone = value.replaceAll(RegExp(r'[^\d]'), '');
                    if (cleanPhone.length < 10) {
                      return 'Please enter a valid phone number';
                    }
                    return null;
                  },
                  style: AppTextStyles.body.copyWith(color: AppColors.white),
                  decoration: InputDecoration(
                    hintText: 'Phone Number',
                    hintStyle: AppTextStyles.body
                        .copyWith(color: AppColors.white.withOpacity(0.7)),
                    prefixIcon: const Icon(Icons.phone, color: AppColors.white),
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

                const SizedBox(height: 32),

                // Create Account button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _register,
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
                            'Create Account',
                            style: AppTextStyles.button.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 32),

                // Login link
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.white,
                        fontSize: 14,
                      ),
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
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Debug: Print the data being sent
      print('Registration data:');
      print('Name: ${_nameController.text.trim()}');
      print('Email: ${_emailController.text.trim()}');
      print('Password: ${_passwordController.text}');
      print('Confirm Password: ${_confirmPasswordController.text}');
      print('Phone: ${_phoneController.text.trim()}');
      print('Avatar ID: ${selectedAvatar + 1}');

      final response = await AuthService.register(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
        confirmPassword: _confirmPasswordController.text,
        phone: _phoneController.text.trim(),
        avatarId: selectedAvatar + 1, // API expects 1-based index
      );

      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response['message'] ?? 'Registration successful!'),
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
            content: Text('Registration failed: ${e.toString()}'),
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
}
