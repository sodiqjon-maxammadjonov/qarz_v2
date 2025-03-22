import 'package:flutter/material.dart';

class FloatingSnackbar {
  static SnackBar? _currentSnackbar;

  /// Muvaffaqiyatli amaliyot haqida xabar beruvchi snackbar
  static void showSuccess({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    _showSnackbar(
      context: context,
      message: message,
      backgroundColor: Colors.green,
      duration: duration,
      icon: const Icon(Icons.check_circle, color: Colors.white),
    );
  }

  /// Ma'lumot yoki ogohlantirishlarni ko'rsatuvchi snackbar
  static void showInfo({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    _showSnackbar(
      context: context,
      message: message,
      backgroundColor: Colors.blue,
      duration: duration,
      icon: const Icon(Icons.info, color: Colors.white),
    );
  }

  /// Xatolik haqida xabar beruvchi snackbar
  static void showError({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    _showSnackbar(
      context: context,
      message: message,
      backgroundColor: Colors.red,
      duration: duration,
      icon: const Icon(Icons.error, color: Colors.white),
    );
  }

  /// Barcha turdagi snackbarlarni yaratish uchun ichki metod
  static void _showSnackbar({
    required BuildContext context,
    required String message,
    required Color backgroundColor,
    required Widget icon,
    Duration duration = const Duration(seconds: 3),
  }) {
    // Mavjud snackbarni o'chirish
    if (_currentSnackbar != null) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      _currentSnackbar = null;
    }

    final messenger = ScaffoldMessenger.of(context);

    _currentSnackbar = SnackBar(
      content: Row(
        children: [
          icon,
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      duration: duration,
      dismissDirection: DismissDirection.horizontal,
      elevation: 4.0,
    );

    messenger.showSnackBar(_currentSnackbar!).closed.then((_) {
      _currentSnackbar = null;
    });
  }
}