import 'package:flutter/material.dart';
import '../constants/app_styles.dart';

// lib/widgets/auth_button.dart
class AuthButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color backgroundColor;
  final IconData? icon; // Add icon parameter

  const AuthButton({
    required this.onPressed,
    required this.text,
    this.backgroundColor = Colors.orangeAccent,
    this.icon, // Optional icon
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return icon != null
        ? ElevatedButton.icon(
      onPressed: onPressed,
      style: AppStyles.elevatedButtonStyle.copyWith(
        backgroundColor: WidgetStateProperty.all(backgroundColor),
      ),
      icon: Icon(icon, color: Colors.black),
      label: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          color: backgroundColor == Colors.white ? Colors.black : Colors.white,
        ),
      ),
    )
        : ElevatedButton(
      onPressed: onPressed,
      style: AppStyles.elevatedButtonStyle.copyWith(
        backgroundColor: WidgetStateProperty.all(backgroundColor),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          color: backgroundColor == Colors.white ? Colors.black : Colors.white,
        ),
      ),
    );
  }
}