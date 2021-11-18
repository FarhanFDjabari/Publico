import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:publico/presentation/pages/home/home_page_admin.dart';
import 'package:publico/presentation/pages/onboarding/onboarding_end_page.dart';
import 'package:publico/presentation/pages/onboarding/onboarding_page.dart';
import 'package:publico/styles/colors.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 750,
      ),
    );

    _animationController.forward().then((value) {
      Timer(const Duration(seconds: 2), () {
        if (GetStorage().read('uid') == null &&
            GetStorage().read('first_open') == null) {
          Navigator.pushReplacementNamed(
            context,
            OnboardingPage.routeName,
          );
        } else if (GetStorage().read('uid') != null &&
            GetStorage().read('first_open') != null) {
          Navigator.pushReplacementNamed(
            context,
            HomePageAdmin.routeName,
          );
        } else {
          Navigator.pushReplacementNamed(
            context,
            OnboardingEndPage.routeName,
          );
        }
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kRed,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: kLinearGradient2,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/svg/Publico-white.svg'),
            const SizedBox(height: 15),
            SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(_animationController),
              child: FadeTransition(
                opacity: _animationController,
                child: const CircularProgressIndicator(
                  color: kRichWhite,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
