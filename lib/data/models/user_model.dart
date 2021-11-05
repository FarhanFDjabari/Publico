import 'package:equatable/equatable.dart';
import 'package:publico/domain/entities/user.dart';

class UserModel extends Equatable {
  final String uid;
  final String? email;
  final String? displayName;
  final String? photoUrl;
  final bool isAnonymous;
  final bool emailVerified;

  const UserModel(
      {required this.uid,
      this.email,
      this.displayName,
      this.photoUrl,
      required this.isAnonymous,
      required this.emailVerified});

  User toEntity() {
    return User(
      uuid: uid,
      isAnonymous: isAnonymous,
      emailVerified: emailVerified,
      photoUrl: photoUrl,
      displayName: displayName,
      email: email,
    );
  }

  @override
  List<Object?> get props => [
        uid,
        email,
        displayName,
        photoUrl,
        isAnonymous,
        emailVerified,
      ];
}
