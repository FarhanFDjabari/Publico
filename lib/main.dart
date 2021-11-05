import 'package:flutter/material.dart';
import 'package:publico/presentation/pages/auth/login_page.dart';
import 'package:publico/presentation/pages/onboarding/onboarding_page.dart';
import 'package:publico/presentation/pages/register_page.dart';
import 'package:publico/presentation/pages/splash_screen.dart';
import 'package:publico/styles/colors.dart';
import 'package:publico/styles/text_styles.dart';

import 'injection.dart' as di;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Publico',
      theme: ThemeData.light().copyWith(
        colorScheme: kColorScheme,
        textTheme: kTextTheme,
      ),
      home: const OnboardingPage(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case OnboardingPage.routeName:
            return MaterialPageRoute(builder: (_) => const OnboardingPage());
          case SplashScreen.routeName:
            return MaterialPageRoute(builder: (_) => const SplashScreen());
          case LoginPage.routeName:
            return MaterialPageRoute(builder: (_) => const LoginPage());
          case RegisterPage.routeName:
            return MaterialPageRoute(builder: (_) => const RegisterPage());
          default:
            return MaterialPageRoute(builder: (_) {
              return const Scaffold(
                body: Center(
                  child: Text('Page not found: False Route'),
                ),
              );
            });
        }
      },
    );
  }
}
