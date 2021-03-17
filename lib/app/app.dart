import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:netguru_task/di/bloc_providers.dart';
import 'package:netguru_task/di/repository_providers.dart';
import 'package:netguru_task/di/service_providers.dart';
import 'package:netguru_task/modules/home/ui/home_screen.dart';
import 'package:netguru_task/utility/colors.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ServiceProviders(
      child: RepositoryProviders(
        child: BlocProviders(
          child: buildApp(context),
        ),
      ),
    );
  }

  MaterialApp buildApp(BuildContext context) {
    final _themeDataLight = ThemeData(
      primaryColor: AppColors.main,
      primaryColorLight: AppColors.mainLight,
      backgroundColor: AppColors.backgroundLight,
      accentColor: AppColors.textDark,
      shadowColor: AppColors.textDarkShadow,
      fontFamily: 'Rubik',
    );

    final _themeDataDark = ThemeData(
      primaryColor: AppColors.main,
      primaryColorLight: AppColors.mainLight,
      backgroundColor: AppColors.backgroundDark,
      accentColor: AppColors.textLight,
      shadowColor: AppColors.textLightShadow,
      fontFamily: 'Rubik',
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
      home: HomeScreen(),
    );
  }
}
