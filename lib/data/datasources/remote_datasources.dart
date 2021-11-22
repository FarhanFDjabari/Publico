import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:get_storage/get_storage.dart';
import 'package:publico/data/models/infographic_model.dart';
import 'package:publico/data/models/theme_model.dart';
import 'package:publico/data/models/user_model.dart';
import 'package:publico/data/models/video_materi_model.dart';
import 'package:publico/data/models/video_singkat_model.dart';
import 'package:publico/util/exception.dart';

abstract class RemoteDataSources {
  Future<UserModel> loginWithEmailPassword(String email, String password);
  Future<void> sendForgetPasswordSignal(String email);
  Future<storage.UploadTask> uploadFiletoStorage(String destination, File file);
  Future<void> logout();
  Future<void> postVideoSingkat(String title, String description,
      String videoUrl, String thumbnailUrl, String tiktokUrl, int duration);
  Future<void> postVideoMateri(String title, String description,
      String videoUrl, String thumbnailUrl, int duration);
  Future<List<VideoSingkatModel>> getVideoSingkatPostsByUid(String uid);
  Future<List<VideoMateriModel>> getVideoMateriPostsByUid(String uid);
  Future<List<InfographicModel>> getInfographicsByThemeId(String themeId);
  Future<List<ThemeModel>> getInfographicThemesByUid(String uid);
  Future<void> postNewTheme(String themeName, String imagePath);
  Future<void> deleteFromStorage(String downloadUrl);
  Future<void> deletePost(String id, String collectionName);
  Future<void> postInfographic(
      String themeId, String themeName, String title, List sources);

  Future<Map<String, dynamic>> getExplore();
  Future<List<VideoMateriModel>> getVideoMateriPosts(String query);
  Future<List<VideoSingkatModel>> getVideoSingkatPosts(String query);
  Future<List<InfographicModel>> getInfographicPosts(String query);
}

class RemoteDataSourcesImpl extends RemoteDataSources {
  final auth.FirebaseAuth firebaseAuth;
  final storage.FirebaseStorage firebaseStorage;
  final firestore.FirebaseFirestore firebaseFirestore;

  RemoteDataSourcesImpl(
      {required this.firebaseAuth,
      required this.firebaseStorage,
      required this.firebaseFirestore});

  @override
  Future<UserModel> loginWithEmailPassword(
      String email, String password) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return UserModel(
        uid: credential.user!.uid,
        email: credential.user!.email,
        displayName: credential.user!.displayName,
        photoUrl: credential.user!.photoURL,
        isAnonymous: credential.user!.isAnonymous,
        emailVerified: credential.user!.emailVerified,
      );
    } catch (error) {
      throw AuthException(error.toString());
    }
  }

  @override
  Future<void> sendForgetPasswordSignal(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (error) {
      throw AuthException(error.toString());
    }
  }

  @override
  Future<void> logout() async {
    try {
      await firebaseAuth.signOut();
    } catch (error) {
      throw AuthException(error.toString());
    }
  }

  @override
  Future<storage.UploadTask> uploadFiletoStorage(
      String destination, File file) async {
    try {
      final ref = firebaseStorage.ref(destination);

      return ref.putFile(file);
    } catch (error) {
      throw ServerException(error.toString());
    }
  }

  @override
  Future<void> deleteFromStorage(String downloadUrl) async {
    try {
      final ref = firebaseStorage.refFromURL(downloadUrl);
      await ref.delete();
    } catch (error) {
      throw ServerException(error.toString());
    }
  }

  @override
  Future<void> postVideoSingkat(
      String title,
      String description,
      String videoUrl,
      String thumbnailUrl,
      String tiktokUrl,
      int duration) async {
    try {
      final ref = firebaseFirestore.collection('video_singkat');
      await ref.add({
        'type': 'Video Singkat',
        'title': title,
        'query': title.toLowerCase(),
        'description': description,
        'video_url': videoUrl,
        'thumbnail_url': thumbnailUrl,
        'tiktok_url': tiktokUrl,
        'duration': duration,
        'admin_id': GetStorage().read('uid'),
      });
    } catch (error) {
      throw ServerException(error.toString());
    }
  }

  @override
  Future<void> postVideoMateri(String title, String description,
      String videoUrl, String thumbnailUrl, int duration) async {
    try {
      final ref = firebaseFirestore.collection('video_materi');
      await ref.add({
        'type': 'Video Materi',
        'title': title,
        'query': title.toLowerCase(),
        'description': description,
        'video_url': videoUrl,
        'thumbnail_url': thumbnailUrl,
        'duration': duration,
        'admin_id': GetStorage().read('uid'),
      });
    } catch (error) {
      throw ServerException(error.toString());
    }
  }

  @override
  Future<List<VideoSingkatModel>> getVideoSingkatPostsByUid(String uid) async {
    try {
      final ref = firebaseFirestore.collection('video_singkat');
      final result = await ref
          .where('admin_id', isEqualTo: GetStorage().read('uid'))
          .get();
      final videoSingkatModels = result.docs
          .map((doc) => VideoSingkatModel.fromSnapshot(doc))
          .toList();
      return videoSingkatModels;
    } catch (error) {
      throw ServerException(error.toString());
    }
  }

  @override
  Future<List<VideoSingkatModel>> getVideoSingkatPosts(String query) async {
    try {
      final ref = firebaseFirestore.collection('video_singkat');
      final result =
          await ref.where('query', isGreaterThanOrEqualTo: query).get();
      final videoSingkatModels = result.docs
          .map((doc) => VideoSingkatModel.fromSnapshot(doc))
          .toList();
      return videoSingkatModels;
    } catch (error) {
      throw ServerException(error.toString());
    }
  }

  @override
  Future<List<VideoMateriModel>> getVideoMateriPostsByUid(String uid) async {
    try {
      final ref = firebaseFirestore.collection('video_materi');
      final result = await ref
          .where('admin_id', isEqualTo: GetStorage().read('uid'))
          .get();
      final videoMateriModels =
          result.docs.map((doc) => VideoMateriModel.fromSnapshot(doc)).toList();
      return videoMateriModels;
    } catch (error) {
      throw ServerException(error.toString());
    }
  }

  @override
  Future<List<VideoMateriModel>> getVideoMateriPosts(String query) async {
    try {
      final ref = firebaseFirestore.collection('video_materi');
      final result =
          await ref.where('query', isGreaterThanOrEqualTo: query).get();
      final videoMateriModels =
          result.docs.map((doc) => VideoMateriModel.fromSnapshot(doc)).toList();
      return videoMateriModels;
    } catch (error) {
      throw ServerException(error.toString());
    }
  }

  @override
  Future<List<InfographicModel>> getInfographicPosts(String query) async {
    try {
      final ref = firebaseFirestore.collection('infographics');
      final result =
          await ref.where('query', isGreaterThanOrEqualTo: query).get();
      final infographicModels =
          result.docs.map((doc) => InfographicModel.fromSnapshot(doc)).toList();
      return infographicModels;
    } catch (error) {
      throw ServerException(error.toString());
    }
  }

  @override
  Future<List<InfographicModel>> getInfographicsByThemeId(
      String themeId) async {
    try {
      final ref = firebaseFirestore.collection('infographics');
      final result = await ref
          .where('admin_id', isEqualTo: GetStorage().read('uid'))
          .where('theme_id', isEqualTo: themeId)
          .get();
      final infographicModels =
          result.docs.map((doc) => InfographicModel.fromSnapshot(doc)).toList();
      return infographicModels;
    } catch (error) {
      throw ServerException(error.toString());
    }
  }

  @override
  Future<List<ThemeModel>> getInfographicThemesByUid(String uid) async {
    try {
      final ref = firebaseFirestore.collection('infographic_themes');
      final result = await ref
          .where('admin_id', isEqualTo: GetStorage().read('uid'))
          .get();
      final infographicThemeModels =
          result.docs.map((doc) => ThemeModel.fromSnapshot(doc)).toList();
      return infographicThemeModels;
    } catch (error) {
      throw ServerException(error.toString());
    }
  }

  @override
  Future<void> postNewTheme(String themeName, String imagePath) async {
    try {
      final ref = firebaseFirestore.collection('infographic_themes');
      await ref.add({
        'theme_name': themeName,
        'thumbnail_url': imagePath,
        'admin_id': GetStorage().read('uid'),
      });
    } catch (error) {
      throw ServerException(error.toString());
    }
  }

  @override
  Future<void> deletePost(String id, String collectionName) async {
    try {
      final ref = firebaseFirestore.collection(collectionName);
      await ref.doc(id).delete();
    } catch (error) {
      throw ServerException(error.toString());
    }
  }

  @override
  Future<void> postInfographic(
      String themeId, String themeName, String title, List sources) async {
    try {
      final ref = firebaseFirestore.collection('infographics');
      await ref.add({
        'theme_id': themeId,
        'theme_name': themeName,
        'title': title,
        'query': title.toLowerCase(),
        'sources': sources,
        'admin_id': GetStorage().read('uid'),
        'type': 'Infografis'
      });
    } catch (error) {
      throw ServerException(error.toString());
    }
  }

  @override
  Future<Map<String, dynamic>> getExplore() async {
    try {
      final infographicsRef = firebaseFirestore.collection('infographics');
      final videoMateriRef = firebaseFirestore.collection('video_materi');
      final videoSingkatRef = firebaseFirestore.collection('video_singkat');
      final resultInfographics = await infographicsRef.get();
      final resultVideoMateri = await videoMateriRef.get();
      final resultVideoSingkat = await videoSingkatRef.get();

      final infographicModels = resultInfographics.docs
          .map((doc) => InfographicModel.fromSnapshot(doc))
          .toList();
      final videoMateriModels = resultVideoMateri.docs
          .map((doc) => VideoMateriModel.fromSnapshot(doc))
          .toList();
      final videoSingkatModels = resultVideoSingkat.docs
          .map((doc) => VideoSingkatModel.fromSnapshot(doc))
          .toList();
      return {
        'infographic_models': infographicModels,
        'video_materi_models': videoMateriModels,
        'video_singkat_models': videoSingkatModels,
      };
    } catch (error) {
      throw ServerException(error.toString());
    }
  }
}
