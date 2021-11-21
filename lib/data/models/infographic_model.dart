import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:publico/domain/entities/infographic.dart';

class InfographicModel extends Equatable {
  final String id;
  final String title;
  final String adminId;
  final String themeId;
  final String themeName;
  final String type;
  final List<dynamic> sources;

  const InfographicModel({
    required this.id,
    required this.title,
    required this.adminId,
    required this.themeId,
    required this.themeName,
    required this.type,
    required this.sources,
  });

  static InfographicModel fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return InfographicModel(
      id: snapshot.id,
      title: snapshot.data()!['title'],
      adminId: snapshot.data()!['admin_id'],
      themeId: snapshot.data()!['theme_id'],
      themeName: snapshot.data()!['theme_name'],
      type: snapshot.data()!['type'],
      sources: snapshot.data()!['sources'],
    );
  }

  Infographic toEntity() {
    return Infographic(
        id: id,
        title: title,
        adminId: adminId,
        themeId: themeId,
        themeName: themeName,
        type: type,
        sources: sources);
  }

  @override
  List<Object?> get props => [id, adminId, themeId, type, sources];
}
