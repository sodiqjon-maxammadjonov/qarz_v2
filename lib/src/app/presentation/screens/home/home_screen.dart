import 'package:flutter/material.dart';
import 'package:qarz_v2/src/app/utils/components/settings/settings_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      children: [
        SettingsItem(icon: Icons.book_rounded, title: l10n.daftar, subtitle: "")
      ],
    );
  }
}
