import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateText extends StatelessWidget {
  final DateTime date;
  final TextStyle? style;
  final String format;

  const DateText({
    super.key,
    required this.date,
    this.style,
    this.format = "dd.mm.yyyy",
  });

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat(format, "uz").format(date);

    return Text(
      formattedDate,
      style: style ?? const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }
}