import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:publico/presentation/pages/onboarding/onboarding_end_page.dart';
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
      'title': 'Video Singkat Penjelasan',
      'subtitle':
          'Pelajari materi tentang ekonomi pembangunan melalui video singkat berdurasi 1 menit yang dapat anda lihat di TikTok juga!',
      'imagePath': 'assets/images/onboard_img_1.png'
    },
    {
      'title': 'Video Lengkap Materi',
      'subtitle':
          'Ingin memahami materi lebih lanjut? lihat video lengkap materi berdurasi 5 hingga 10 menit dari aplikasi Publico',
      'imagePath': 'assets/images/onboard_img_2.png'
    },
    {
      'title': 'Infografis Ekonomi',
      'subtitle':
          'Dapatkan infografis lengkap mengenai materi ekonomi pembangunan berdasarkan sumber-sumber yang kredibel',
      'imagePath': 'assets/images/onboard_img_3.png'
    }
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
    final _screenWidth = MediaQuery.of(context).size.width;
    final _screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Container(
          width: _screenWidth,
          height: _screenHeight,
          color: kRed,
        ),
        Container(
          decoration: BoxDecoration(
            gradient: kLinearGradient,
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SizedBox(
              width: _screenWidth,
              height: _screenHeight,
              child: Stack(
                children: [
                  Column(
                    children: [
                      const Spacer(
                        flex: 6,
                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: kRichWhite,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(100),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: _screenHeight / 12,
                      ),
                      Expanded(
                        flex: 4,
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
                              Flexible(
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: index == 2
                                          ? Alignment.bottomRight
                                          : Alignment.bottomLeft,
                                      child: Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 5),
                                          child: Image.asset(
                                            onBoardingData[index]['imagePath']!,
                                            fit: BoxFit.contain,
                                          )),
                                    ),
                                    Align(
                                      alignment: index == 2
                                          ? Alignment.bottomLeft
                                          : Alignment.bottomRight,
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 18.0,
                                          vertical: 30,
                                        ),
                                        child: Column(
                                          mainAxisAlignment: index == 1
                                              ? MainAxisAlignment.start
                                              : MainAxisAlignment.end,
                                          crossAxisAlignment: index == 2
                                              ? CrossAxisAlignment.start
                                              : CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              onBoardingData[index]['title']!
                                                          .split(" ")
                                                          .length ==
                                                      2
                                                  ? onBoardingData[index]
                                                          ['title']!
                                                      .split(" ")[0]
                                                  : "${onBoardingData[index]['title']!.split(" ")[0]} ${onBoardingData[index]['title']!.split(" ")[1]}",
                                              style: kHeading5.copyWith(
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            Text(
                                              onBoardingData[index]['title']!
                                                  .split(" ")
                                                  .last,
                                              style: kOverline.copyWith(
                                                  fontSize: 20),
                                            ),
                                            SizedBox(
                                              height: _screenHeight / 8,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 30),
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 10, bottom: 20),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
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
                        height: 9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            onBoardingData.length,
                            (index) => _buildOnboardingDot(index: index),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: _screenWidth / 6,
                            vertical: 30,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Spacer(flex: 1),
                              PrimaryButton(
                                onPressed: () async {
                                  await GetStorage()
                                      .write('first_open', false)
                                      .then(
                                        (value) =>
                                            Navigator.pushReplacementNamed(
                                          context,
                                          OnboardingEndPage.routeName,
                                        ),
                                      );
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
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  AnimatedContainer _buildOnboardingDot({required int index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 750),
      width: 9,
      height: 9,
      margin: const EdgeInsets.only(right: 9),
      decoration: BoxDecoration(
        color: currentIndex == index ? kMikadoOrange : kLightGrey,
        shape: BoxShape.circle,
      ),
    );
  }
}
