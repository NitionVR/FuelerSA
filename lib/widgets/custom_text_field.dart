import 'package:flutter/material.dart';
import 'package:fuel_price_tracker/constants/app_styles.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool isPassword;
  final IconData? prefixIcon;

  const CustomTextField({
    required this.controller,
    required this.label,
    this.isPassword = false,
    this.prefixIcon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      style: const TextStyle(color: Colors.white),
      decoration: AppStyles.inputDecoration(label).copyWith(
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: Colors.white70)
            : null,
      ),
    );
  }
}
