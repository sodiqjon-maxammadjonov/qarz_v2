import 'package:flutter/material.dart';

class FloatingSnackbar {
  static SnackBar? _currentSnackbar;

  static void showLoading({
    required BuildContext context,
    required String message,
  }) {
    _showSnackbar(
      context: context,
      message: message,
      backgroundColor: Colors.blue,
    );
  }

  static void showError({
    required BuildContext context,
    required String message,
  }) {
    _showSnackbar(
      context: context,
      message: message,
      backgroundColor: Colors.red, // Xatolik uchun qizil rang
    );
  }

  static void showSuccess({
    required BuildContext context,
    required String message,
  }) {
    _showSnackbar(
      context: context,
      message: message,
      backgroundColor: Colors.green, // Muvaffaqiyat uchun yashil rang
    );
  }

  static void _showSnackbar({
    required BuildContext context,
    required String message,
    required Color backgroundColor,
  }) {
    final messenger = ScaffoldMessenger.of(context);

    if (_currentSnackbar != null) return;

    _currentSnackbar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      duration: const Duration(seconds: 3),
    );

    messenger.showSnackBar(_currentSnackbar!).closed.then((_) {
      _currentSnackbar = null;
    });
  }
}
