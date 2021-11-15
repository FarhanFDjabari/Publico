import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:get_it/get_it.dart';
import 'package:publico/data/datasources/remote_datasources.dart';
import 'package:publico/data/repositories/repository_impl.dart';
import 'package:publico/domain/repositories/repository.dart';
import 'package:publico/domain/usecases/login_with_email_and_password.dart';
import 'package:publico/domain/usecases/logout.dart';
import 'package:publico/domain/usecases/send_forget_password.dart';
import 'package:publico/domain/usecases/upload_file_to_storage.dart';
import 'package:publico/presentation/bloc/auth/auth_cubit.dart';

import 'data/datasources/db/database_helper.dart';

final locator = GetIt.instance;

void init() {
  // cubit
  locator.registerFactory(
    () => AuthCubit(
      loginWithEmailAndPassword: locator(),
      logout: locator(),
      sendForgetPassword: locator(),
    ),
  );

  // usecases
  locator.registerLazySingleton(() => LoginWithEmailAndPassword(locator()));
  locator.registerLazySingleton(() => Logout(locator()));
  locator.registerLazySingleton(() => SendForgetPassword(locator()));
  locator.registerLazySingleton(() => UploadFileToStorage(locator()));

  // repository
  locator.registerLazySingleton<Repository>(
    () => RepositoryImpl(
      remoteDataSources: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<RemoteDataSources>(
      () => RemoteDataSourcesImpl(firebaseAuth: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => auth.FirebaseAuth.instance);
}
