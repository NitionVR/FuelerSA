import 'package:flutter/material.dart';

class AppStyles {
  static const orangeAccent = Colors.orangeAccent;
  static final darkBackground = Colors.grey[900];
  static final darkAppBar = Colors.grey[850];

  static final inputDecoration = (String label) => InputDecoration(
    labelText: label,
    labelStyle: const TextStyle(color: Colors.white70),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.white24),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: orangeAccent),
    ),
  );

  static final elevatedButtonStyle = ElevatedButton.styleFrom(
    padding: const EdgeInsets.all(15.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    backgroundColor: orangeAccent,
  );
}