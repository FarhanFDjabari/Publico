import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:publico/presentation/bloc/auth/auth_cubit.dart';
import 'package:publico/presentation/widgets/loading_button.dart';
import 'package:publico/presentation/widgets/primary_button.dart';
import 'package:publico/styles/colors.dart';
import 'package:publico/styles/text_styles.dart';

class ForgetPasswordPage extends StatelessWidget {
  static const routeName = '/reset-password';

  ForgetPasswordPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
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
                      'Atur Ulang Kata Sandi Anda',
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
                      autofocus: false,
                    ),
                    const SizedBox(height: 30),
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (listenerContext, state) {
                        if (state is AuthError) {
                          ScaffoldMessenger.of(context).showMaterialBanner(
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
                        } else if (state is AuthForgetPasswordSent) {
                          ScaffoldMessenger.of(context).showMaterialBanner(
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
                              padding: const EdgeInsets.only(top: 20),
                              leadingPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              leading: const Icon(
                                Icons.check_circle,
                                color: Colors.green,
                              ),
                              backgroundColor: kRichBlack.withOpacity(0.75),
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
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              builderContext
                                  .read<AuthCubit>()
                                  .sendForgetPasswordVerification(
                                      _emailController.text);
                            }
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
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Ingat Kata Sandi Anda?',
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
