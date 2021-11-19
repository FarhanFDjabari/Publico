import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:get_storage/get_storage.dart';
import 'package:publico/data/models/user_model.dart';
import 'package:publico/util/exception.dart';

abstract class RemoteDataSources {
  Future<UserModel> loginWithEmailPassword(String email, String password);
  Future<void> sendForgetPasswordSignal(String email);
  Future<storage.UploadTask> uploadFiletoStorage(String destination, File file);
  Future<void> logout();
  Future<void> postVideoSingkat(
      String title, String description, String videoUrl, String tiktokUrl);
  Future<void> postVideoMateri(
      String title, String description, String videoUrl);
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
  Future<void> postVideoSingkat(String title, String description,
      String videoUrl, String tiktokUrl) async {
    try {
      final ref = firebaseFirestore.collection('video_singkat');
      await ref.add({
        'type': 'Video Singkat',
        'title': title,
        'description': description,
        'videoUrl': videoUrl,
        'tiktokUrl': tiktokUrl,
        'admin_id': GetStorage().read('uid'),
      });
    } catch (error) {
      throw ServerException(error.toString());
    }
  }

  @override
  Future<void> postVideoMateri(
      String title, String description, String videoUrl) async {
    try {
      final ref = firebaseFirestore.collection('video_materi');
      await ref.add({
        'type': 'Video Materi',
        'title': title,
        'description': description,
        'videoUrl': videoUrl,
        'admin_id': GetStorage().read('uid'),
      });
    } catch (error) {
      throw ServerException(error.toString());
    }
  }
}
