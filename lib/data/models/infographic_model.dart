import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:publico/domain/entities/infographic.dart';

class InfographicModel extends Equatable {
  final String id;
  final String title;
  final String adminId;
  final String themeId;
  final List<dynamic> sources;

  const InfographicModel({
    required this.id,
    required this.title,
    required this.adminId,
    required this.themeId,
    required this.sources,
  });

  static InfographicModel fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return InfographicModel(
      id: snapshot.id,
      title: snapshot.data()!['title'],
      adminId: snapshot.data()!['admin_id'],
      themeId: snapshot.data()!['theme_id'],
      sources: snapshot.data()!['sources'],
    );
  }

  Infographic toEntity() {
    return Infographic(
        id: id,
        title: title,
        adminId: adminId,
        themeId: themeId,
        sources: sources);
  }

  @override
  List<Object?> get props => [id, adminId, themeId, sources];
}
