import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:publico/domain/entities/theme.dart';

class ThemeModel extends Equatable {
  final String id;
  final String adminId;
  final String themeName;
  final String imgPath;

  const ThemeModel({
    required this.id,
    required this.adminId,
    required this.themeName,
    required this.imgPath,
  });

  static ThemeModel fromSnapshot(DocumentSnapshot snapshot) {
    return ThemeModel(
      id: snapshot.id,
      adminId: snapshot['admin_id'],
      imgPath: snapshot['thumbnail_url'],
      themeName: snapshot['theme_name'],
    );
  }

  Theme toEntity() {
    return Theme(
      id: id,
      adminId: adminId,
      imgPath: imgPath,
      themeName: themeName,
    );
  }

  @override
  List<Object?> get props => [id, adminId, themeName, imgPath];
}
