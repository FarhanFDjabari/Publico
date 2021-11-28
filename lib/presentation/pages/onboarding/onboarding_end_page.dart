import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_version/new_version.dart';
import 'package:publico/presentation/pages/auth/login_page.dart';
import 'package:publico/presentation/pages/home/home_page_user.dart';
import 'package:publico/presentation/widgets/outline_button.dart' as ob;
import 'package:publico/presentation/widgets/primary_button.dart';
import 'package:publico/presentation/widgets/publico_snackbar.dart';
import 'package:publico/styles/colors.dart';
import 'package:publico/styles/text_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class OnboardingEndPage extends StatefulWidget {
  static const routeName = '/onboarding-end';
  const OnboardingEndPage({Key? key}) : super(key: key);

  @override
  State<OnboardingEndPage> createState() => _OnboardingEndPageState();
}

class _OnboardingEndPageState extends State<OnboardingEndPage> {
  @override
  void initState() {
    super.initState();
    _checkVersion();
  }

  void _checkVersion() async {
    final newVersion = NewVersion(
      androidId: 'com.publico.publico',
      iOSAppStoreCountry: 'id',
      iOSId: 'com.publico.publico',
    );
    final status = await newVersion.getVersionStatus();
    if (status != null && status.canUpdate) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: kRichWhite.withOpacity(0.85),
              title: Text('Update v${status.storeVersion}'),
              titleTextStyle: kTextTheme.headline6!.copyWith(
                color: kRichBlack,
              ),
              actionsOverflowButtonSpacing: 20,
              content: Text(
                  'Aplikasi ini (v${status.localVersion}) memiliki update terbaru'),
              contentTextStyle: kTextTheme.subtitle1!.copyWith(
                color: kRichBlack,
              ),
              actions: [
                PrimaryButton(
                  child: Text(
                    'Update',
                    style: kTextTheme.button!.copyWith(color: kRichWhite),
                  ),
                  onPressed: () async {
                    if (!await launch(status.appStoreLink)) {
                      Get.showSnackbar(
                        PublicoSnackbar(
                          message: 'Can\'t launch url',
                        ),
                      );
                    }
                  },
                ),
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    final _screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kRed,
      body: Container(
        width: _screenWidth,
        height: _screenHeight,
        decoration: BoxDecoration(gradient: kLinearGradient2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Expanded(
                flex: 7,
                child: Hero(
                    tag: const Key('onboarding-img-end'),
                    child: Image.asset('assets/images/onboard_img_end.png'))),
            const SizedBox(
              height: 18,
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 70.0),
                child: Column(
                  children: [
                    ob.OutlineButton(
                      child: SizedBox(
                        height: 45,
                        child: Center(
                          child: Text(
                            'Masuk Sebagai Pengunjung',
                            style: kButton.copyWith(color: kRichWhite),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, HomePageUser.routeName);
                      },
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, LoginPage.routeName);
                        },
                        child: Text(
                          'Masuk sebagai Admin',
                          style: kBodyText.copyWith(color: kRichWhite),
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
