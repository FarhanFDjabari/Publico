import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:publico/presentation/widgets/primary_button.dart';
import 'package:publico/styles/colors.dart';
import 'package:publico/styles/text_styles.dart';

class ForgetPasswordPage extends StatelessWidget {
  static const routeName = '/reset-password';
  ForgetPasswordPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
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
                PrimaryButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {}
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
    );
  }
}
