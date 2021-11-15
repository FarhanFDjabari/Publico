import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:publico/domain/entities/user.dart';
import 'package:publico/domain/usecases/login_with_email_and_password.dart';
import 'package:publico/domain/usecases/logout.dart';
import 'package:publico/domain/usecases/send_forget_password.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required this.loginWithEmailAndPassword,
    required this.logout,
    required this.sendForgetPassword,
  }) : super(AuthInitial());
  final LoginWithEmailAndPassword loginWithEmailAndPassword;
  final Logout logout;
  final SendForgetPassword sendForgetPassword;

  void loginEmailAndPassword(String email, String password) async {
    emit(AuthLoading());
    final result = await loginWithEmailAndPassword.execute(email, password);
    result.fold(
      (l) => emit(AuthError(l.message)),
      (r) => emit(AuthSuccess(r)),
    );
  }

  void logoutApp() async {
    emit(AuthLoading());
    final result = await logout.execute();
    result.fold(
      (l) => emit(AuthError(l.message)),
      (r) => emit(AuthDeleteSuccess()),
    );
  }

  void sendForgetPasswordVerification(String email) async {
    emit(AuthLoading());
    final result = await sendForgetPassword.execute(email);
    result.fold(
      (l) => emit(AuthError(l.message)),
      (r) => emit(AuthForgetPasswordSent()),
    );
  }
}
