import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:get_it/get_it.dart';
import 'package:publico/data/datasources/remote_datasources.dart';
import 'package:publico/data/repositories/repository_impl.dart';
import 'package:publico/domain/repositories/repository.dart';
import 'package:publico/domain/usecases/admin/post_video_singkat.dart';
import 'package:publico/domain/usecases/login_with_email_and_password.dart';
import 'package:publico/domain/usecases/logout.dart';
import 'package:publico/domain/usecases/send_forget_password.dart';
import 'package:publico/domain/usecases/upload_file_to_storage.dart';
import 'package:publico/presentation/bloc/auth/auth_cubit.dart';
import 'package:publico/presentation/bloc/video_singkat/video_singkat_cubit.dart';

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
  locator.registerFactory(
    () => VideoSingkatCubit(
      postVideoSingkat: locator(),
    ),
  );

  // usecases
  locator.registerLazySingleton(() => LoginWithEmailAndPassword(locator()));
  locator.registerLazySingleton(() => Logout(locator()));
  locator.registerLazySingleton(() => SendForgetPassword(locator()));
  locator.registerLazySingleton(() => UploadFileToStorage(locator()));

  locator.registerLazySingleton(() => PostVideoSingkat(locator()));

  // repository
  locator.registerLazySingleton<Repository>(
    () => RepositoryImpl(
      remoteDataSources: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<RemoteDataSources>(() => RemoteDataSourcesImpl(
      firebaseAuth: locator(),
      firebaseStorage: locator(),
      firebaseFirestore: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => auth.FirebaseAuth.instance);
  locator.registerLazySingleton(() => storage.FirebaseStorage.instance);
  locator.registerLazySingleton(() => firestore.FirebaseFirestore.instance);
}
