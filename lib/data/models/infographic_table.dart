import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:publico/domain/entities/infographic.dart';

import 'infographic_model.dart';

class InfographicTable extends Equatable {
  final String id;
  final String title;
  final String adminId;
  final String themeId;
  final String themeName;
  final String type;
  final List<dynamic> sources;

  const InfographicTable({
    required this.id,
    required this.title,
    required this.adminId,
    required this.themeId,
    required this.themeName,
    required this.type,
    required this.sources,
  });

  factory InfographicTable.fromEntity(Infographic infographic) =>
      InfographicTable(
        id: infographic.id,
        adminId: infographic.adminId,
        title: infographic.title,
        type: infographic.type,
        themeName: infographic.themeName,
        themeId: infographic.themeId,
        sources: infographic.sources,
      );

  factory InfographicTable.fromMap(Map<String, dynamic> map) =>
      InfographicTable(
        id: map['id'],
        adminId: map['admin_id'],
        title: map['title'],
        type: map['type'],
        themeId: map['theme_id'],
        themeName: map['theme_name'],
        sources: json.decode(map['sources']),
      );

  factory InfographicTable.fromDTO(InfographicModel infographicModel) =>
      InfographicTable(
        id: infographicModel.id,
        adminId: infographicModel.adminId,
        title: infographicModel.title,
        type: infographicModel.type,
        themeId: infographicModel.themeId,
        themeName: infographicModel.themeName,
        sources: infographicModel.sources,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'admin_id': adminId,
        'title': title,
        'type': type,
        'theme_id': themeId,
        'theme_name': themeName,
        'sources': json.encode(sources),
      };

  Infographic toEntity() {
    return Infographic.bookmark(
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
