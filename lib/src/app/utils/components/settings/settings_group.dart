import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../presentation/bloc/settings/settings_bloc.dart';
class SettingsGroup extends StatelessWidget {
  final String title;
  final TextStyle? titleStyle;
  final List<Widget> children;

  const SettingsGroup({
    Key? key,
    required this.title,
    this.titleStyle,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocBuilder<SettingsBloc, SettingsState>(
  builder: (context, state) {
      final fontSize = state.fontSize;
      return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.02,
            vertical: screenWidth * 0.02,
          ),
          child: Text(
            title,
            style: titleStyle ??
                TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  },
);
  }
}
