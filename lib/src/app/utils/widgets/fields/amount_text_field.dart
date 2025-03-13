import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/app_theme.dart';

class AmountTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final String? errorText;
  final bool enabled;
  final FocusNode? focusNode;
  final VoidCallback? onTap;
  final Widget? suffixIcon;
  final Widget? prefixIcon;

  const AmountTextField({
    super.key,
    required this.controller,
    this.label = 'Miqdorni kiriting',
    this.hintText = '1 000 000',
    this.onChanged,
    this.errorText,
    this.enabled = true,
    this.focusNode,
    this.onTap,
    this.suffixIcon,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Ekran o'lchamiga qarab moslashuvchan o'lchamlar
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 360;
    final horizontalPadding = isSmallScreen ? 12.0 : 16.0;
    final verticalPadding = isSmallScreen ? 12.0 : 14.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(
              bottom: 6.0,
              left: 4.0,
            ),
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.textColor,
                fontSize: isSmallScreen ? 14 : 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        TextField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: false),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            AmountInputFormatter(),
          ],
          enabled: enabled,
          focusNode: focusNode,
          onTap: onTap,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.textColor,
            fontSize: isSmallScreen ? 16 : 18,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: theme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.textColor.withValues(alpha: 0.5),
            ),
            errorText: errorText,
            errorStyle: theme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.error,
              fontSize: 12,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            filled: true,
            fillColor: enabled
                ? Colors.white
                : AppTheme.background,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: AppTheme.textColor.withValues(alpha: 0.3),
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: AppTheme.primary,
                width: 2.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: AppTheme.textColor.withValues(alpha: 0.3),
                width: 1.0,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: AppTheme.textColor.withValues(alpha: 0.1),
                width: 1.0,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: AppTheme.error,
                width: 1.0,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: AppTheme.error,
                width: 2.0,
              ),
            ),
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class AmountInputFormatter extends TextInputFormatter {
  final String thousandSeparator;

  AmountInputFormatter({
    this.thousandSeparator = ' ',
  });

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Faqat raqamlarni olamiz
    final digitsOnly = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    // Oldingi va yangi matnlarning raqamlarini solishtiramiz
    // Kursorni to'g'ri joyda saqlash uchun
    final oldDigitsOnly = oldValue.text.replaceAll(RegExp(r'[^\d]'), '');

    // Yangi qo'shilgan raqamlar soni
    int cursorOffset = digitsOnly.length - oldDigitsOnly.length;

    // Raqamlarni o'ngdan chapga uchlab ajratamiz
    String result = '';
    for (int i = 0; i < digitsOnly.length; i++) {
      if (i > 0 && (digitsOnly.length - i) % 3 == 0) {
        result += thousandSeparator;
      }
      result += digitsOnly[i];
    }

    // Kursorni to'g'ri pozitsiyaga qo'yamiz
    // Yangi formatdagi qo'shimcha space belgilari sonini hisobga olamiz
    int spacesBeforeCursor = 0;
    if (oldValue.selection.end <= oldValue.text.length) {
      final beforeCursor = result.length - (oldDigitsOnly.length - oldValue.selection.end) - cursorOffset;
      for (int i = 0; i < beforeCursor; i++) {
        if (i < result.length && result[i] == thousandSeparator) {
          spacesBeforeCursor++;
        }
      }
    }

    int cursorPosition = oldValue.selection.end + cursorOffset + spacesBeforeCursor;
    if (cursorPosition > result.length) {
      cursorPosition = result.length;
    } else if (cursorPosition < 0) {
      cursorPosition = 0;
    }

    return TextEditingValue(
      text: result,
      selection: TextSelection.collapsed(offset: cursorPosition),
    );
  }
}