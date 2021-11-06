import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String uuid;
  final String? email;
  final String? displayName;
  final String? photoUrl;
  final bool isAnonymous;
  final bool emailVerified;

  const User(
      {required this.uuid,
      this.email,
      this.displayName,
      this.photoUrl,
      required this.isAnonymous,
      required this.emailVerified});

  @override
  List<Object?> get props => [
        uuid,
        email,
        displayName,
        photoUrl,
        isAnonymous,
        emailVerified,
      ];
}
