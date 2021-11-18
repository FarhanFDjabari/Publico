import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:publico/presentation/bloc/auth/auth_cubit.dart';
import 'package:publico/presentation/widgets/loading_button.dart';
import 'package:publico/presentation/widgets/primary_button.dart';
import 'package:publico/styles/colors.dart';
import 'package:publico/styles/text_styles.dart';

class ForgetPasswordPage extends StatefulWidget {
  static const routeName = '/reset-password';

  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  bool isValidate = false;

  void formCheck() {
    if (_emailController.text.isEmpty || !_emailController.text.contains('@')) {
      if (!isValidate) {
        return;
      } else {
        setState(() {
          isValidate = false;
        });
      }
    } else {
      setState(() {
        isValidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    final _screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kRed,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        top: true,
        bottom: true,
        child: SingleChildScrollView(
          child: Container(
            width: _screenWidth,
            height: _screenHeight - MediaQuery.of(context).padding.top,
            decoration: BoxDecoration(
              gradient: kLinearGradient2,
            ),
            child: Column(
              children: [
                Container(
                  constraints: BoxConstraints(
                    minHeight: _screenHeight * 0.2,
                  ),
                ),
                const Spacer(),
                Container(
                  constraints: BoxConstraints(
                    maxHeight: _screenHeight * 0.6,
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 20),
                        decoration: const BoxDecoration(
                          color: kRichWhite,
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(100)),
                        ),
                        child: Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/svg/Publico.svg',
                                  height: 36,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Atur Ulang Kata Sandi Anda',
                                  style: kTextTheme.subtitle1!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: kRichBlack,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Email',
                                    style: kTextTheme.bodyText2!.copyWith(
                                      color: kMikadoOrange,
                                    ),
                                  ),
                                ),
                                TextFormField(
                                    controller: _emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      hintText: 'Masukkan email',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    style: kTextTheme.bodyText2!.copyWith(
                                      color: kRichBlack,
                                    ),
                                    autofocus: false,
                                    onChanged: (value) {
                                      Timer(const Duration(milliseconds: 500),
                                          () {
                                        formCheck();
                                      });
                                    }),
                                const Spacer(),
                                BlocConsumer<AuthCubit, AuthState>(
                                  listener: (listenerContext, state) {
                                    if (state is AuthError) {
                                      ScaffoldMessenger.of(context)
                                          .showMaterialBanner(
                                        MaterialBanner(
                                          content: Text(state.message),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                ScaffoldMessenger.of(context)
                                                    .hideCurrentMaterialBanner();
                                              },
                                              child: const Text('Oke'),
                                            ),
                                          ],
                                          padding:
                                              const EdgeInsets.only(top: 20),
                                          leadingPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 10),
                                          leading: const Icon(
                                            Icons.error,
                                            color: Colors.red,
                                          ),
                                          backgroundColor:
                                              kRichBlack.withOpacity(0.75),
                                        ),
                                      );
                                    } else if (state
                                        is AuthForgetPasswordSent) {
                                      ScaffoldMessenger.of(context)
                                          .showMaterialBanner(
                                        MaterialBanner(
                                          content: const Text(
                                              'Silahkan cek email anda untuk melakukan reset password'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                ScaffoldMessenger.of(context)
                                                    .hideCurrentMaterialBanner();
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Oke'),
                                            ),
                                          ],
                                          padding:
                                              const EdgeInsets.only(top: 20),
                                          leadingPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 10),
                                          leading: const Icon(
                                            Icons.check_circle,
                                            color: Colors.green,
                                          ),
                                          backgroundColor:
                                              kRichBlack.withOpacity(0.75),
                                        ),
                                      );
                                    }
                                  },
                                  builder: (builderContext, state) {
                                    if (state is AuthLoading) {
                                      return LoadingButton(
                                        borderRadius: 10,
                                        primaryColor: kLightGrey,
                                        child: const SizedBox(
                                          width: double.infinity,
                                          height: 45,
                                          child: Center(
                                            child: SizedBox(
                                              width: 20,
                                              height: 20,
                                              child: CircularProgressIndicator(
                                                color: kRichWhite,
                                                strokeWidth: 3,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    return PrimaryButton(
                                      onPressed: !isValidate
                                          ? null
                                          : () {
                                              builderContext
                                                  .read<AuthCubit>()
                                                  .sendForgetPasswordVerification(
                                                      _emailController.text);
                                            },
                                      borderRadius: 10,
                                      primaryColor: kMikadoOrange,
                                      child: SizedBox(
                                        width: double.infinity,
                                        height: 45,
                                        child: Center(
                                          child: Text(
                                            'Atur Ulang Kata Sandi',
                                            style: kTextTheme.button!.copyWith(
                                              color: kRichWhite,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Kembali',
                                      style: kTextTheme.bodyText2!.copyWith(
                                        color: kMikadoOrange,
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: -_screenHeight * 0.38 + 30,
                        child: Image.asset(
                          'assets/images/onboard_img_end.png',
                          height: _screenHeight * 0.38,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
