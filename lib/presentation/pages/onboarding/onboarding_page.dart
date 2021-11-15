import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:publico/presentation/pages/auth/login_page.dart';
import 'package:publico/presentation/pages/home/home_page_user.dart';
import 'package:publico/presentation/widgets/primary_button.dart';
import 'package:publico/styles/colors.dart';
import 'package:publico/styles/text_styles.dart';

class OnboardingPage extends StatefulWidget {
  static const routeName = '/onboarding';
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int currentIndex = 0;
  final onBoardingController = PageController(initialPage: 0);
  late Timer _onBoardingScroll;

  final List<Map<String, String>> onBoardingData = [
    {
      'title': 'Infografis Ekonomi',
      'subtitle':
          'Dapatkan infografis lengkap mengenai materi ekonomi pembangunan berdasarkan sumber-sumber yang kredibel',
      'imagePath': 'assets/svg/amico.svg'
    },
    {
      'title': 'Video Singkat Penjelasan',
      'subtitle':
          'Pelajari materi tentang ekonomi pembangunan melalui video singkat berdurasi 1 menit yang dapat anda lihat di TikTok juga!',
      'imagePath': 'assets/svg/amico_2.svg'
    },
    {
      'title': 'Video Lengkap Materi',
      'subtitle':
          'Ingin memahami materi lebih lanjut? lihat video lengkap materi berdurasi 5 hingga 7 menit dari aplikasi Publico',
      'imagePath': 'assets/svg/amico_3.svg'
    },
  ];

  @override
  void initState() {
    super.initState();
    _onBoardingScroll = Timer.periodic(
      const Duration(seconds: 4),
      (timer) {
        if (currentIndex < 3) {
          currentIndex++;
        } else {
          currentIndex = 0;
        }
        onBoardingController.animateToPage(currentIndex,
            duration: const Duration(milliseconds: 750), curve: Curves.easeOut);
      },
    );
  }

  @override
  void dispose() {
    _onBoardingScroll.cancel();
    onBoardingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: onBoardingController,
                  pageSnapping: true,
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemCount: onBoardingData.length,
                  itemBuilder: (_, index) => Column(
                    children: [
                      const Spacer(flex: 1),
                      Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        child: SvgPicture.asset(
                          onBoardingData[index]['imagePath']!,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        onBoardingData[index]['title']!,
                        style: kTextTheme.headline6!.copyWith(
                          color: kRichBlack,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 20),
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        width: double.infinity,
                        child: Text(
                          onBoardingData[index]['subtitle']!,
                          textAlign: TextAlign.center,
                          style: kTextTheme.bodyText2!.copyWith(
                            color: kGrey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    onBoardingData.length,
                    (index) => _buildOnboardingDot(index: index),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Spacer(flex: 1),
                      PrimaryButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const HomePageUser(),
                              ));
                        },
                        child: SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: Center(
                            child: Text(
                              'Lewati Pengenalan',
                              style: kTextTheme.button!
                                  .copyWith(color: kRichWhite),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const LoginPage(),
                              ));
                        },
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                  text: 'Anda seorang admin? ',
                                  style: kTextTheme.bodyText2!.copyWith(
                                    color: kGrey,
                                  )),
                              TextSpan(
                                  text: 'Masuk Disini.',
                                  style: kTextTheme.bodyText2!.copyWith(
                                    color: kMikadoOrange,
                                    fontWeight: FontWeight.w500,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AnimatedContainer _buildOnboardingDot({required int index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 750),
      width: 5,
      height: 5,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        color: currentIndex == index ? kMikadoOrange : kLightGrey,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
