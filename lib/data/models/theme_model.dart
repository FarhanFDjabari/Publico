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
