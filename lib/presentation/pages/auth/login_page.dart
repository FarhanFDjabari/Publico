import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:publico/presentation/bloc/auth/auth_cubit.dart';
import 'package:publico/presentation/pages/auth/forget_password_page.dart';
import 'package:publico/presentation/pages/home/home_page_admin.dart';
import 'package:publico/presentation/widgets/loading_button.dart';
import 'package:publico/presentation/widgets/primary_button.dart';
import 'package:publico/styles/colors.dart';
import 'package:publico/styles/text_styles.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login';

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isObscured = true;
  bool isValidate = false;

  void formCheck() {
    if (_emailController.text.isEmpty ||
        !_emailController.text.contains('@') ||
        _passwordController.text.length < 8) {
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
                Stack(
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
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SvgPicture.asset(
                                'assets/svg/Publico.svg',
                                height: 36,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Masuk Untuk Admin Aplikasi',
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
                                autofocus: true,
                                decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintText: 'Masukkan email',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                style: kTextTheme.bodyText2!.copyWith(
                                  height: 1,
                                  color: kRichBlack,
                                ),
                                onChanged: (value) {
                                  Timer(const Duration(milliseconds: 500), () {
                                    formCheck();
                                  });
                                },
                              ),
                              const SizedBox(height: 8),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Kata Sandi',
                                  style: kTextTheme.bodyText2!.copyWith(
                                    color: kMikadoOrange,
                                  ),
                                ),
                              ),
                              SizedBox(
                                child: TextFormField(
                                  controller: _passwordController,
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: InputDecoration(
                                    hintText: 'Masukkan kata sandi',
                                    helperText: 'Minimal 8 karakter',
                                    helperMaxLines: 1,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _isObscured = !_isObscured;
                                        });
                                      },
                                      icon: Icon(
                                        _isObscured
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  style: kTextTheme.bodyText2!.copyWith(
                                    color: kRichBlack,
                                    height: 1,
                                  ),
                                  obscureText: _isObscured,
                                  autofocus: false,
                                  autocorrect: false,
                                  onChanged: (value) {
                                    Timer(const Duration(milliseconds: 500),
                                        () {
                                      formCheck();
                                    });
                                  },
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => ForgetPasswordPage(),
                                        ));
                                  },
                                  child: Text('Lupa Kata Sandi?',
                                      style: kTextTheme.bodyText2!.copyWith(
                                        color: kGrey,
                                      )),
                                ),
                              ),
                              // const SizedBox(height: 20),
                              BlocConsumer<AuthCubit, AuthState>(
                                listener: (listenerContext, state) {
                                  if (state is AuthError) {
                                    ScaffoldMessenger.of(context)
                                        .showMaterialBanner(
                                      MaterialBanner(
                                        content: Text(
                                            'Autentikasi Error: ${state.message}'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              ScaffoldMessenger.of(context)
                                                  .hideCurrentMaterialBanner();
                                            },
                                            child: const Text('Oke'),
                                          ),
                                        ],
                                        padding: const EdgeInsets.only(top: 20),
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
                                  } else if (state is AuthSuccess) {
                                    Navigator.of(context).pushReplacementNamed(
                                      HomePageAdmin.routeName,
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
                                                .loginEmailAndPassword(
                                                  _emailController.text,
                                                  _passwordController.text,
                                                );
                                          },
                                    borderRadius: 10,
                                    primaryColor: kMikadoOrange,
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: 45,
                                      child: Center(
                                        child: Text(
                                          'Masuk Admin',
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
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ForgetPasswordPage(),
                                      ));
                                },
                                child: Text(
                                  'Bukan admin? Masuk',
                                  style: kTextTheme.bodyText2!.copyWith(
                                    color: kGrey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: -_screenHeight * 0.4 + 30,
                      child: Image.asset(
                        'assets/images/onboard_img_end.png',
                        height: _screenHeight * 0.4,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
