import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:publico/presentation/bloc/auth/auth_cubit.dart';
import 'package:publico/presentation/pages/admin/infographics_tab.dart';
import 'package:publico/presentation/pages/admin/video_materi_tab.dart';
import 'package:publico/presentation/pages/admin/video_singkat_tab.dart';
import 'package:publico/presentation/pages/splash_screen.dart';
import 'package:publico/presentation/widgets/chip_button.dart';
import 'package:publico/presentation/widgets/publico_setting_bottom_sheet.dart';
import 'package:publico/styles/colors.dart';

class HomePageAdmin extends StatefulWidget {
  static const routeName = '/home-admin';

  const HomePageAdmin({Key? key}) : super(key: key);

  @override
  State<HomePageAdmin> createState() => _HomePageAdminState();
}

class _HomePageAdminState extends State<HomePageAdmin>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int _selectedIndex = 0;

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
          Navigator.of(context).pushNamedAndRemoveUntil(
            SplashScreen.routeName,
            (route) => false,
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
                return IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      backgroundColor: kRichWhite,
                      context: context,
                      isDismissible: true,
                      builder: (_) => PublicoSettingBottomSheet(
                        parentContext: context,
                        onExitPressed: () {
                          builderContext.read<AuthCubit>().logoutApp();
                        },
                        onHelpPressed: () {},
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.settings,
                    color: kRichBlack,
                  ),
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () {
                        setState(() {
                          _selectedIndex = 0;
                        });
                        tabController.animateTo(0);
                      },
                      child: ChipButton(
                        title: 'Infografis',
                        selectedIndex: _selectedIndex,
                        itemIndex: 0,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedIndex = 1;
                        });
                        tabController.animateTo(1);
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: ChipButton(
                        title: 'Video Materi',
                        selectedIndex: _selectedIndex,
                        itemIndex: 1,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedIndex = 2;
                        });
                        tabController.animateTo(2);
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: ChipButton(
                        title: 'Video Singkat',
                        selectedIndex: _selectedIndex,
                        itemIndex: 2,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    InfographicsTab(),
                    VideoMateriTab(),
                    VideoSingkatTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
