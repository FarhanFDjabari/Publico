import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:get_it/get_it.dart';
import 'package:publico/data/datasources/local_datasources.dart';
import 'package:publico/data/datasources/remote_datasources.dart';
import 'package:publico/data/repositories/repository_impl.dart';
import 'package:publico/domain/repositories/repository.dart';
import 'package:publico/domain/usecases/admin/delete_infographic_post.dart';
import 'package:publico/domain/usecases/admin/get_infographic_by_theme_id.dart';
import 'package:publico/domain/usecases/admin/get_infographic_themes_by_uid.dart';
import 'package:publico/domain/usecases/admin/get_video_materi_posts_by_uid.dart';
import 'package:publico/domain/usecases/admin/get_video_singkat_posts_by_uid.dart';
import 'package:publico/domain/usecases/admin/delete_video_post.dart';
import 'package:publico/domain/usecases/admin/post_infographic.dart';
import 'package:publico/domain/usecases/admin/post_infographic_theme.dart';
import 'package:publico/domain/usecases/admin/post_video_singkat.dart';
import 'package:publico/domain/usecases/login_with_email_and_password.dart';
import 'package:publico/domain/usecases/logout.dart';
import 'package:publico/domain/usecases/send_forget_password.dart';
import 'package:publico/domain/usecases/upload_file_to_storage.dart';
import 'package:publico/domain/usecases/user/get_explore.dart';
import 'package:publico/presentation/bloc/auth/auth_cubit.dart';
import 'package:publico/presentation/bloc/explore/cubit/explore_cubit.dart';
import 'package:publico/presentation/bloc/infographic/infographic_cubit.dart';
import 'package:publico/presentation/bloc/video_materi/video_materi_cubit.dart';
import 'package:publico/presentation/bloc/video_singkat/video_singkat_cubit.dart';

import 'data/datasources/db/database_helper.dart';
import 'domain/usecases/admin/post_video_materi.dart';

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
      getVideoSingkatPostsByUid: locator(),
      deleteVideoPost: locator(),
    ),
  );
  locator.registerFactory(
    () => VideoMateriCubit(
      postVideoMateri: locator(),
      getVideoMateriPostsByUid: locator(),
      deleteVideoPost: locator(),
    ),
  );
  locator.registerFactory(
    () => InfographicCubit(
      postInfographicTheme: locator(),
      getInfographicThemesByUid: locator(),
      postInfographic: locator(),
      getInfographicsByThemeId: locator(),
      deleteInfographicPost: locator(),
    ),
  );
  locator.registerFactory(() => ExploreCubit(getExplore: locator()));

  // usecases
  locator.registerLazySingleton(() => LoginWithEmailAndPassword(locator()));
  locator.registerLazySingleton(() => Logout(locator()));
  locator.registerLazySingleton(() => SendForgetPassword(locator()));
  locator.registerLazySingleton(() => UploadFileToStorage(locator()));

  locator.registerLazySingleton(() => PostVideoSingkat(locator()));
  locator.registerLazySingleton(() => PostVideoMateri(locator()));
  locator.registerLazySingleton(() => GetVideoSingkatPostsByUid(locator()));
  locator.registerLazySingleton(() => GetVideoMateriPostsByUid(locator()));
  locator.registerLazySingleton(() => GetInfographicsByThemeId(locator()));
  locator.registerLazySingleton(() => GetInfographicThemesByUid(locator()));
  locator.registerLazySingleton(() => PostInfographicTheme(locator()));
  locator.registerLazySingleton(() => DeleteVideoPost(locator()));
  locator.registerLazySingleton(() => PostInfographic(locator()));
  locator.registerLazySingleton(() => DeleteInfographicPost(locator()));

  locator.registerLazySingleton(() => GetExplore(locator()));

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
  locator.registerLazySingleton<LocalDataSources>(() => LocalDataSourceImpl(
        databaseHelper: locator(),
      ));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => auth.FirebaseAuth.instance);
  locator.registerLazySingleton(() => storage.FirebaseStorage.instance);
  locator.registerLazySingleton(() => firestore.FirebaseFirestore.instance);
}
