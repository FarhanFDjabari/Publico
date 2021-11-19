import 'package:equatable/equatable.dart';

class Theme extends Equatable {
  final String id;
  final String adminId;
  final String themeName;
  final String imgPath;

  const Theme({
    required this.id,
    required this.adminId,
    required this.themeName,
    required this.imgPath,
  });

  @override
  List<Object?> get props => [id, adminId, themeName, imgPath];
}
