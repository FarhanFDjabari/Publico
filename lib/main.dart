import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:publico/domain/entities/infographic.dart';
import 'package:publico/domain/entities/theme.dart' as theme_entity;
import 'package:publico/domain/entities/video_materi.dart';
import 'package:publico/domain/entities/video_singkat.dart';
import 'package:publico/presentation/bloc/auth/auth_cubit.dart';
import 'package:publico/presentation/bloc/bookmark/cubit/bookmark_cubit.dart';
import 'package:publico/presentation/bloc/explore/cubit/explore_cubit.dart';
import 'package:publico/presentation/bloc/infographic/infographic_cubit.dart';
import 'package:publico/presentation/bloc/search/search_cubit.dart';
import 'package:publico/presentation/bloc/video_materi/video_materi_cubit.dart';
import 'package:publico/presentation/bloc/video_singkat/video_singkat_cubit.dart';
import 'package:publico/presentation/pages/admin/detail/admin_infographics_detail.dart';
import 'package:publico/presentation/pages/admin/detail/admin_video_materi_detail.dart';
import 'package:publico/presentation/pages/admin/detail/admin_video_singkat_detail.dart';
import 'package:publico/presentation/pages/admin/edit/edit_sources_page.dart';
import 'package:publico/presentation/pages/admin/edit/infographic_edit_page.dart';
import 'package:publico/presentation/pages/admin/edit/video_materi_edit_page.dart';
import 'package:publico/presentation/pages/admin/edit/video_singkat_edit_page.dart';
import 'package:publico/presentation/pages/admin/infographics_tab.dart';
import 'package:publico/presentation/pages/admin/post/add_source_page.dart';
import 'package:publico/presentation/pages/admin/post/infographic_post_page.dart';
import 'package:publico/presentation/pages/admin/post/post_theme_page.dart';
import 'package:publico/presentation/pages/admin/post/video_materi_post_page.dart';
import 'package:publico/presentation/pages/admin/post/video_singkat_post_page.dart';
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
import 'package:publico/presentation/pages/onboarding/onboarding_end_page.dart';
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
        BlocProvider<VideoSingkatCubit>(
          create: (_) => di.locator<VideoSingkatCubit>(),
        ),
        BlocProvider<VideoMateriCubit>(
          create: (_) => di.locator<VideoMateriCubit>(),
        ),
        BlocProvider<InfographicCubit>(
          create: (_) => di.locator<InfographicCubit>(),
        ),
        BlocProvider<ExploreCubit>(
          create: (_) => di.locator<ExploreCubit>(),
        ),
        BlocProvider<BookmarkCubit>(
          create: (_) => di.locator<BookmarkCubit>(),
        ),
        BlocProvider<SearchCubit>(
          create: (_) => di.locator<SearchCubit>(),
        ),
      ],
      child: GetMaterialApp(
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
            case OnboardingEndPage.routeName:
              return MaterialPageRoute(
                  builder: (_) => const OnboardingEndPage());
            case SplashScreen.routeName:
              return MaterialPageRoute(builder: (_) => const SplashScreen());
            case LoginPage.routeName:
              return MaterialPageRoute(builder: (_) => const LoginPage());
            case ForgetPasswordPage.routeName:
              return MaterialPageRoute(
                  builder: (_) => const ForgetPasswordPage());
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
              final themes = settings.arguments as List<theme_entity.Theme>;
              return MaterialPageRoute(
                  builder: (_) => InfographicPostPage(themes: themes));
            case PostThemePage.routeName:
              return MaterialPageRoute(builder: (_) => const PostThemePage());
            case VideoMateriPostPage.routeName:
              return MaterialPageRoute(
                  builder: (_) => const VideoMateriPostPage());
            case VideoSingkatPostPage.routeName:
              return MaterialPageRoute(
                  builder: (_) => const VideoSingkatPostPage());
            case VideoMateriTab.routeName:
              return MaterialPageRoute(builder: (_) => const VideoMateriTab());
            case VideoSingkatTab.routeName:
              return MaterialPageRoute(builder: (_) => const VideoSingkatTab());
            case InfographicsDetailPage.routeName:
              final infographic = settings.arguments as Infographic;
              return CupertinoPageRoute(
                builder: (_) =>
                    InfographicsDetailPage(infographic: infographic),
                settings: settings,
              );
            case AdminInfographicsDetailPage.routeName:
              final infographic = settings.arguments as Infographic;
              return CupertinoPageRoute(
                builder: (_) =>
                    AdminInfographicsDetailPage(infographic: infographic),
                settings: settings,
              );
            case AddSourcePage.routeName:
              return CupertinoPageRoute(
                builder: (_) => const AddSourcePage(),
              );
            case VideoMateriDetailPage.routeName:
              final videoMateri = settings.arguments as VideoMateri;
              return CupertinoPageRoute(
                builder: (_) => VideoMateriDetailPage(videoMateri: videoMateri),
                settings: settings,
              );
            case AdminVideoMateriDetailPage.routeName:
              final videoMateri = settings.arguments as VideoMateri;
              return CupertinoPageRoute(
                builder: (_) =>
                    AdminVideoMateriDetailPage(videoMateri: videoMateri),
                settings: settings,
              );
            case VideoSingkatDetailPage.routeName:
              final videoSingkat = settings.arguments as VideoSingkat;
              return CupertinoPageRoute(
                builder: (_) =>
                    VideoSingkatDetailPage(videoSingkat: videoSingkat),
                settings: settings,
              );
            case AdminVideoSingkatDetailPage.routeName:
              final videoSingkat = settings.arguments as VideoSingkat;
              return CupertinoPageRoute(
                builder: (_) =>
                    AdminVideoSingkatDetailPage(videoSingkat: videoSingkat),
                settings: settings,
              );
            case InfographicEditPage.routeName:
              final id = settings.arguments as String;
              return CupertinoPageRoute(
                builder: (_) => InfographicEditPage(postId: id),
                settings: settings,
              );
            case VideoMateriEditPage.routeName:
              final videoMateri = settings.arguments as VideoMateri;
              return CupertinoPageRoute(
                builder: (_) => VideoMateriEditPage(videoMateri: videoMateri),
                settings: settings,
              );
            case VideoSingkatEditPage.routeName:
              final videoSingkat = settings.arguments as VideoSingkat;
              return CupertinoPageRoute(
                builder: (_) =>
                    VideoSingkatEditPage(videoSingkat: videoSingkat),
                settings: settings,
              );
            case EditSourcesPage.routeName:
              final id = settings.arguments as String;
              return CupertinoPageRoute(
                builder: (_) => EditSourcesPage(sourceId: id),
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
