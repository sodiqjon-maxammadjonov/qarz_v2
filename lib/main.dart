import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qarz_v2/src/app/presentation/bloc/login/login_bloc.dart';
import 'package:qarz_v2/src/app/presentation/bloc/settings/settings_bloc.dart';
import 'package:qarz_v2/src/app/presentation/screens/main/main_screen.dart';
import 'package:qarz_v2/src/core/theme/app_theme.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => LoginBloc()
        ),
        BlocProvider(
          create: (context) => SettingsBloc()..add(InitializeSettingsEvent()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Qarz Daftar',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: state.themeMode,
          home: const MainScreen(),
          locale: Locale(state.language),
          supportedLocales: const [
            Locale('uz'),
            Locale('en'),
            Locale('ru'),
          ],
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        );
      },
    );
  }
}
