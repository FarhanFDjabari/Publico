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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            top: true,
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/svg/Publico.svg',
                      height: 50,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Masuk Untuk Admin Aplikasi',
                      style: kTextTheme.subtitle1!.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: kRichBlack,
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      autofocus: true,
                      decoration: InputDecoration(
                        labelText: 'Alamat Email',
                        hintText: 'Alamat Email',
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
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Format email tidak valid';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        labelText: 'Kata Sandi',
                        hintText: 'Kata Sandi',
                        helperMaxLines: 1,
                        helperText: 'minimal 8 karakter',
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
                          icon: Icon(_isObscured
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                      ),
                      style: kTextTheme.bodyText2!.copyWith(
                        color: kRichBlack,
                      ),
                      obscureText: _isObscured,
                      autofocus: false,
                      autocorrect: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Kata sandi tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (listenerContext, state) {
                        if (state is AuthError) {
                          ScaffoldMessenger.of(context).showMaterialBanner(
                            MaterialBanner(
                              content:
                                  Text('Autentikasi Error: ${state.message}'),
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
                                  const EdgeInsets.symmetric(horizontal: 10),
                              leading: const Icon(
                                Icons.error,
                                color: Colors.red,
                              ),
                              backgroundColor: kRichBlack.withOpacity(0.75),
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
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              builderContext
                                  .read<AuthCubit>()
                                  .loginEmailAndPassword(
                                    _emailController.text,
                                    _passwordController.text,
                                  );
                            }
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
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ForgetPasswordPage(),
                            ));
                      },
                      child: Text('Lupa Kata Sandi Anda?',
                          style: kTextTheme.bodyText2!.copyWith(
                            color: kGrey,
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
