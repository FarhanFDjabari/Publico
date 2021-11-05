import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:get_it/get_it.dart';
import 'package:publico/data/datasources/remote_datasources.dart';
import 'package:publico/data/repositories/repository_impl.dart';
import 'package:publico/domain/repositories/repository.dart';
import 'package:publico/domain/usecases/login_with_email_and_password.dart';
import 'package:publico/domain/usecases/logout.dart';
import 'package:publico/domain/usecases/sign_up_with_email_and_password.dart';
import 'package:publico/presentation/bloc/auth/auth_cubit.dart';

final locator = GetIt.instance;

void init() {
  // cubit
  locator.registerFactory(
    () => AuthCubit(
      loginWithEmailAndPassword: locator(),
      signUpWithEmailAndPassword: locator(),
      logout: locator(),
    ),
  );

  // usecases
  locator.registerLazySingleton(() => LoginWithEmailAndPassword(locator()));
  locator.registerLazySingleton(() => SignUpWithEmailAndPassword(locator()));
  locator.registerLazySingleton(() => Logout(locator()));

  // repository
  locator.registerLazySingleton<Repository>(
    () => RepositoryImpl(
      remoteDataSources: locator(),
    ),
  );

  // datasources
  locator.registerLazySingleton<RemoteDataSources>(
      () => RemoteDataSourcesImpl(firebaseAuth: locator()));

  // external
  locator.registerLazySingleton(() => auth.FirebaseAuth.instance);
}
