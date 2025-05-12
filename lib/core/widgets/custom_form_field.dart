import 'package:flutter/material.dart';
import 'package:nti_r2/core/helper/my_validator.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({super.key, required this.validator,
    required this.controller, this.obscureText = false, this.suffixIcon,
    this.label, this.onChanged});
final AppValidator validator;
final TextEditingController controller;
final bool obscureText;
final Widget? suffixIcon;
final String? label;
final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      controller: controller,
      validator: validator.validate,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: suffixIcon
      ),

    );
  }
}
