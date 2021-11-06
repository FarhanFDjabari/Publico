import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:publico/presentation/bloc/auth/auth_cubit.dart';
import 'package:publico/presentation/pages/splash_screen.dart';
import 'package:publico/presentation/widgets/loading_button.dart';
import 'package:publico/styles/colors.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showMaterialBanner(
            MaterialBanner(
              content: Text('Autentikasi Error: ${state.message}'),
              actions: [
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                  },
                  child: const Text('Oke'),
                ),
              ],
              padding: const EdgeInsets.only(top: 20),
              leadingPadding: const EdgeInsets.symmetric(horizontal: 10),
              leading: const Icon(
                Icons.error,
                color: Colors.red,
              ),
              backgroundColor: kRichBlack.withOpacity(0.75),
            ),
          );
        } else if (state is AuthDeleteSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Logout Sukses'),
            ),
          );
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const SplashScreen()),
          );
        }
      },
      child: Scaffold(
        body: Center(
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (builderContext, state) {
              if (state is AuthLoading) {
                return LoadingButton(
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return ElevatedButton(
                onPressed: () {
                  builderContext.read<AuthCubit>().logoutApp();
                },
                child: const SizedBox(
                  width: 80,
                  height: 20,
                  child: Center(
                      child: Text(
                    'Logout',
                    style: TextStyle(color: kRichWhite),
                  )),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
