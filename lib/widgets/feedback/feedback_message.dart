import 'package:event_management/constants/colors.dart';
import 'package:flutter/material.dart';

class FeedbackMessage {
  static void showSnackBar(context, String? message) {
    SnackBar snackBar = SnackBar(
      duration: const Duration(seconds: 8),
      backgroundColor: ProjectColors.black54Color,
      content: Text(
        message!,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 14, color: ProjectColors.whiteColor),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
