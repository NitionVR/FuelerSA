import 'package:flutter/material.dart';

// lib/utils/dialog_utils.dart
class DialogUtils {
  static void showErrorSnackBar(BuildContext context, String message) {
    _showSnackBar(context, message, Colors.red);
  }

  static void showSuccessSnackBar(BuildContext context, String message) {
    _showSnackBar(context, message, Colors.green);
  }

  static void _showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}