import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:publico/presentation/bloc/auth/auth_cubit.dart';
import 'package:publico/presentation/pages/admin/infographics_tab.dart';
import 'package:publico/presentation/pages/admin/video_materi_tab.dart';
import 'package:publico/presentation/pages/admin/video_singkat_tab.dart';
import 'package:publico/presentation/pages/splash_screen.dart';
import 'package:publico/presentation/widgets/loading_button.dart';
import 'package:publico/styles/colors.dart';
import 'package:publico/styles/text_styles.dart';

class HomePageAdmin extends StatefulWidget {
  static const routeName = '/home-admin';

  const HomePageAdmin({Key? key}) : super(key: key);

  @override
  State<HomePageAdmin> createState() => _HomePageAdminState();
}

class _HomePageAdminState extends State<HomePageAdmin>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showMaterialBanner(
            MaterialBanner(
              content: Text('Autentikasi Error: ${state.message}'),
              actions: [
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                  },
                  child: const Text('Oke'),
                ),
              ],
              padding: const EdgeInsets.only(top: 20),
              leadingPadding: const EdgeInsets.symmetric(horizontal: 10),
              leading: const Icon(
                Icons.error,
                color: Colors.red,
              ),
              backgroundColor: kRichBlack.withOpacity(0.75),
            ),
          );
        } else if (state is AuthDeleteSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Logout Sukses'),
            ),
          );
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const SplashScreen()),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kRichWhite,
          elevation: 0,
          title: SvgPicture.asset(
            'assets/svg/Publico.svg',
            height: 24,
            width: 50,
          ),
          centerTitle: true,
          actions: [
            BlocBuilder<AuthCubit, AuthState>(
              builder: (builderContext, state) {
                if (state is AuthLoading) {
                  return LoadingButton(
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return ElevatedButton(
                  onPressed: () {
                    builderContext.read<AuthCubit>().logoutApp();
                  },
                  child: const SizedBox(
                    width: 80,
                    height: 20,
                    child: Center(
                        child: Text(
                      'Logout',
                      style: TextStyle(color: kRichWhite),
                    )),
                  ),
                );
              },
            ),
          ],
          bottom: TabBar(
            controller: tabController,
            tabs: [
              Tab(
                child: Text(
                  'Infografis',
                  style: kTextTheme.subtitle1!.copyWith(
                    fontSize: 14,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'Video Materi',
                  style: kTextTheme.subtitle1!.copyWith(
                    fontSize: 14,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'Video Singkat',
                  style: kTextTheme.subtitle1!.copyWith(
                    fontSize: 14,
                  ),
                ),
              ),
            ],
            unselectedLabelColor: kLightGrey,
            labelColor: kMikadoOrange,
            indicatorColor: kMikadoOrange,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 4,
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: const [
            InfographicsTab(),
            VideoMateriTab(),
            VideoSingkatTab(),
          ],
        ),
      ),
    );
  }
}
