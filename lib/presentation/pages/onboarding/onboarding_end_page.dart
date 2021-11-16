import 'package:flutter/material.dart';
import 'package:publico/presentation/pages/auth/login_page.dart';
import 'package:publico/presentation/pages/home/home_page_user.dart';
import 'package:publico/presentation/widgets/outline_button.dart' as ob;
import 'package:publico/styles/colors.dart';
import 'package:publico/styles/text_styles.dart';

class OnboardingEndPage extends StatelessWidget {
  static const routeName = '/onboarding-end';
  const OnboardingEndPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: kLinearGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Expanded(
                  flex: 7,
                  child: Image.asset('assets/images/onboard_img_end.png')),
              const SizedBox(
                height: 18,
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    ob.OutlineButton(
                      child: Text(
                        'Masuk Sebagai Pengunjung',
                        style: kButton.copyWith(color: kRichWhite),
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
                          'Masuk Sebagai Admin',
                          style: kBodyText.copyWith(color: kRichWhite),
                        ))
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
