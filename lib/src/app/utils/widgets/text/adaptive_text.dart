import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../presentation/bloc/settings/settings_bloc.dart';

class AdaptiveText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final double? multiplier;
  final Color? customColor;
  final FontWeight? fontWeight;
  final int? maxLines;
  final TextOverflow? overflow;
  final int maxLength;

  const AdaptiveText(
      this.text, {
        super.key,
        this.style,
        this.textAlign,
        this.multiplier = 1.0,
        this.customColor,
        this.fontWeight,
        this.maxLines = 1,
        this.overflow = TextOverflow.ellipsis,
        this.maxLength = 50,
      });

  String _truncateText(String originalText) {
    return originalText.length > maxLength
        ? originalText.substring(0, maxLength) + '...'
        : originalText;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final truncatedText = _truncateText(text);

    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        final double baseFontSize = state.fontSize;
        final adjustedFontSize = baseFontSize * (multiplier ?? 1.0);

        return Text(
          truncatedText,
          style: style?.copyWith(
            fontSize: adjustedFontSize,
            color: customColor ?? theme.textTheme.bodyMedium?.color,
            fontWeight: fontWeight ?? theme.textTheme.bodyMedium?.fontWeight,
          ) ?? TextStyle(
            fontSize: adjustedFontSize,
            color: customColor ?? theme.textTheme.bodyMedium?.color,
            fontWeight: fontWeight ?? theme.textTheme.bodyMedium?.fontWeight,
          ),
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
        );
      },
    );
  }

  // Tema stillaridan foydalanuvchi factory constructorlar
  factory AdaptiveText.headline1(
      String text, {
        Color? color,
        double multiplier = 1.0,
      }) => AdaptiveText(
    text,
    multiplier: multiplier * 1.5,
    fontWeight: FontWeight.bold,
    customColor: color,
  );

  factory AdaptiveText.subtitle(
      String text, {
        Color? color,
        double multiplier = 1.0,
      }) => AdaptiveText(
    text,
    multiplier: multiplier * 1.2,
    fontWeight: FontWeight.w600,
    customColor: color,
  );

  factory AdaptiveText.caption(
      String text, {
        Color? color,
        double multiplier = 1.0,
      }) => AdaptiveText(
    text,
    multiplier: multiplier * 0.8,
    fontWeight: FontWeight.w400,
    customColor: color,
  );
}