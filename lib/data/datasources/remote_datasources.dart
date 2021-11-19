import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:publico/data/models/user_model.dart';
import 'package:publico/util/exception.dart';

abstract class RemoteDataSources {
  Future<UserModel> loginWithEmailPassword(String email, String password);
  Future<void> sendForgetPasswordSignal(String email);
  Future<UploadTask> uploadFiletoStorage(String destination, File file);
  Future<void> logout();

  Future<void> postVideoSingkat(
      String title, String description, String videoUrl, String tiktokUrl);
}

class RemoteDataSourcesImpl extends RemoteDataSources {
  final auth.FirebaseAuth firebaseAuth;

  RemoteDataSourcesImpl({required this.firebaseAuth});

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
  Future<UploadTask> uploadFiletoStorage(String destination, File file) async {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putFile(file);
    } catch (error) {
      throw ServerException(error.toString());
    }
  }

  @override
  Future<void> postVideoSingkat(String title, String description,
      String videoUrl, String tiktokUrl) async {
    try {
      final ref = FirebaseFirestore.instance.collection('video_singkats');
      await ref.add({
        'title': title,
        'description': description,
        'videoUrl': videoUrl,
        'tiktokUrl': tiktokUrl,
        'admin_id': firebaseAuth.currentUser!.uid
      });
    } catch (error) {
      throw ServerException(error.toString());
    }
  }
}
