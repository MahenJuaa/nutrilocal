import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'providers/theme_provider.dart';
import 'providers/nutrition_provider.dart';

import 'screens/splash/splash_screen.dart';

import 'core/theme/app_theme.dart';

void main() async {

  WidgetsFlutterBinding
      .ensureInitialized();

  final prefs =
      await SharedPreferences
          .getInstance();

  final isLoggedIn =
      prefs.getBool(
            'isLoggedIn',
          ) ??
          false;

  runApp(

    MyApp(

      isLoggedIn:
          isLoggedIn,
    ),
  );
}

class MyApp
    extends StatelessWidget {

  final bool isLoggedIn;

  const MyApp({

    super.key,

    required this.isLoggedIn,
  });

  @override
  Widget build(BuildContext context) {

    return MultiProvider(

      providers: [

        ChangeNotifierProvider(

          create: (_) =>
              ThemeProvider(),
        ),

        ChangeNotifierProvider(

          create: (_) =>
              NutritionProvider(),
        ),
      ],

      child:
          Consumer<
              ThemeProvider>(

        builder:
            (
              context,
              themeProvider,
              child,
            ) {

          return MaterialApp(

            debugShowCheckedModeBanner:
                false,

            themeMode:
                themeProvider
                    .currentTheme,

            theme: AppTheme.lightTheme,

            darkTheme:
    AppTheme.darkTheme,

            home:
                SplashScreen(

              isLoggedIn:
                  isLoggedIn,
            ),
          );
        },
      ),
    );
  }
}