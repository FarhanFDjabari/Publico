import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:publico/presentation/bloc/auth/auth_cubit.dart';
import 'package:publico/presentation/pages/admin/infographics_tab.dart';
import 'package:publico/presentation/pages/admin/post/infographic_post_page.dart';
import 'package:publico/presentation/pages/admin/video_materi_tab.dart';
import 'package:publico/presentation/pages/admin/video_singkat_tab.dart';
import 'package:publico/presentation/pages/auth/forget_password_page.dart';
import 'package:publico/presentation/pages/auth/login_page.dart';
import 'package:publico/presentation/pages/bookmark/bookmark_page.dart';
import 'package:publico/presentation/pages/detail/infographics_detail_page.dart';
import 'package:publico/presentation/pages/detail/video_materi_detail_page.dart';
import 'package:publico/presentation/pages/detail/video_singkat_detail_page.dart';
import 'package:publico/presentation/pages/explore/explore_page.dart';
import 'package:publico/presentation/pages/home/home_page_admin.dart';
import 'package:publico/presentation/pages/home/home_page_user.dart';
import 'package:publico/presentation/pages/onboarding/onboarding_page.dart';
import 'package:publico/presentation/pages/search/search_page.dart';
import 'package:publico/presentation/pages/splash_screen.dart';
import 'package:publico/styles/colors.dart';
import 'package:publico/styles/text_styles.dart';

import 'injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (_) => di.locator<AuthCubit>(),
        ),
      ],
      child: MaterialApp(
        title: 'Publico',
        theme: ThemeData.light().copyWith(
          colorScheme: kColorScheme,
          textTheme: kTextTheme,
        ),
        home: const SplashScreen(),
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case OnboardingPage.routeName:
              return MaterialPageRoute(builder: (_) => const OnboardingPage());
            case SplashScreen.routeName:
              return MaterialPageRoute(builder: (_) => const SplashScreen());
            case LoginPage.routeName:
              return MaterialPageRoute(builder: (_) => const LoginPage());
            case ForgetPasswordPage.routeName:
              return MaterialPageRoute(builder: (_) => ForgetPasswordPage());
            case HomePageUser.routeName:
              return MaterialPageRoute(builder: (_) => const HomePageUser());
            case HomePageAdmin.routeName:
              return MaterialPageRoute(builder: (_) => const HomePageAdmin());
            case ExplorePage.routeName:
              return MaterialPageRoute(builder: (_) => const ExplorePage());
            case SearchPage.routeName:
              return MaterialPageRoute(builder: (_) => const SearchPage());
            case BookmarkPage.routeName:
              return MaterialPageRoute(builder: (_) => const BookmarkPage());
            case InfographicsTab.routeName:
              return MaterialPageRoute(builder: (_) => const InfographicsTab());
            case InfographicPostPage.routeName:
              return MaterialPageRoute(
                  builder: (_) => const InfographicPostPage());
            case VideoMateriTab.routeName:
              return MaterialPageRoute(builder: (_) => const VideoMateriTab());
            case VideoSingkatTab.routeName:
              return MaterialPageRoute(builder: (_) => const VideoSingkatTab());
            case InfographicsDetailPage.routeName:
              final id = settings.arguments as String;
              return CupertinoPageRoute(
                builder: (_) => const InfographicsDetailPage(),
                settings: settings,
              );
            case VideoMateriDetailPage.routeName:
              final id = settings.arguments as String;
              return CupertinoPageRoute(
                builder: (_) => const VideoMateriDetailPage(),
                settings: settings,
              );
            case VideoSingkatDetailPage.routeName:
              final id = settings.arguments as String;
              return CupertinoPageRoute(
                builder: (_) => const VideoSingkatDetailPage(),
                settings: settings,
              );
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
      ),
    );
  }
}
