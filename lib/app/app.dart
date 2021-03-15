import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:netguru_task/home_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:netguru_task/utility/colors.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final _themeDataLight = ThemeData(
      primaryColor: AppColors.main,
      primaryColorLight: AppColors.mainLight,
      backgroundColor: AppColors.backgroundLight,
      accentColor: AppColors.textLight,
      fontFamily: 'SFProText',
    );

    final _themeDataDark = ThemeData(
      primaryColor: AppColors.main,
      primaryColorLight: AppColors.mainLight,
      backgroundColor: AppColors.backgroundDark,
      accentColor: AppColors.textDark,
      fontFamily: 'SFProText',
    );

    return MaterialApp(
      theme: _themeDataLight,
      darkTheme: _themeDataDark,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const HomePage(),
    );
  }
}
