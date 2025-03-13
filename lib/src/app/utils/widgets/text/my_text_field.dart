import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/app_theme.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final String? errorText;
  final bool enabled;
  final bool isPassword;
  final FocusNode? focusNode;
  final VoidCallback? onTap;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputType keyboardType;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final bool autofocus;
  final TextInputAction? textInputAction;
  final EdgeInsetsGeometry? contentPadding;
  final TextCapitalization textCapitalization;

  const MyTextField({
    super.key,
    required this.controller,
    this.label = '',
    this.hintText,
    this.onChanged,
    this.errorText,
    this.enabled = true,
    this.isPassword = false,
    this.focusNode,
    this.onTap,
    this.suffixIcon,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.inputFormatters,
    this.autofocus = false,
    this.textInputAction,
    this.contentPadding,
    this.textCapitalization = TextCapitalization.none,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool _obscureText = true;

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
        if (widget.label.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(
              bottom: 6.0,
              left: 4.0,
            ),
            child: Text(
              widget.label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.textColor,
                fontSize: isSmallScreen ? 14 : 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        TextField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          obscureText: widget.isPassword ? _obscureText : false,
          maxLines: widget.isPassword ? 1 : widget.maxLines,
          minLines: widget.minLines,
          maxLength: widget.maxLength,
          enabled: widget.enabled,
          focusNode: widget.focusNode,
          onTap: widget.onTap,
          autofocus: widget.autofocus,
          textInputAction: widget.textInputAction,
          textCapitalization: widget.textCapitalization,
          inputFormatters: widget.inputFormatters,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.textColor,
            fontSize: isSmallScreen ? 16 : 18,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: theme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.textColor.withValues(alpha: 0.5),
            ),
            errorText: widget.errorText,
            errorStyle: theme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.error,
              fontSize: 12,
            ),
            contentPadding: widget.contentPadding ?? EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            suffixIcon: widget.isPassword
                ? IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
                color: AppTheme.textColor.withValues(alpha: 0.6),
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            )
                : widget.suffixIcon,
            prefixIcon: widget.prefixIcon,
            filled: true,
            fillColor: widget.enabled
                ? Colors.white
                : AppTheme.background,
            counterText: "",
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
          onChanged: widget.onChanged,
        ),
      ],
    );
  }
}