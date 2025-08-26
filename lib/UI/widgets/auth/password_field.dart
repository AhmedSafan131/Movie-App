import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import '../custom_text_field.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final IconData? prefixIcon;

  const PasswordField({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.prefixIcon,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: widget.controller,
      hintText: widget.hintText,
      keyboardType: TextInputType.visiblePassword,
      obscureText: !_isPasswordVisible,
      prefixIcon: Icon(widget.prefixIcon ?? Icons.lock, color: AppColors.white),
      suffixIcon: IconButton(
        icon: Icon(
          _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
          color: AppColors.white,
        ),
        onPressed: () {
          setState(() {
            _isPasswordVisible = !_isPasswordVisible;
          });
        },
      ),
      validator: widget.validator,
    );
  }
}
