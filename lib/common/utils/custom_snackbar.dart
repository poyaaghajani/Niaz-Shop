import 'package:flutter/material.dart';

class CustomSnackbar {
  static showSnack(context, String message, Color color, Color backColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        duration: const Duration(milliseconds: 800),
        behavior: SnackBarBehavior.floating,
        backgroundColor: backColor,
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: color,
          ),
        ),
      ),
    );
  }
}
