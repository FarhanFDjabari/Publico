import 'package:equatable/equatable.dart';

class Infographic extends Equatable {
  final String id;
  final String title;
  final String adminId;
  final String themeId;
  final String themeName;
  final String type;
  final List<dynamic> sources;

  const Infographic({
    required this.id,
    required this.title,
    required this.adminId,
    required this.themeId,
    required this.themeName,
    required this.type,
    required this.sources,
  });

  const Infographic.bookmark({
    required this.id,
    required this.title,
    required this.adminId,
    required this.themeId,
    required this.themeName,
    required this.type,
    required this.sources,
  });

  @override
  List<Object?> get props => [id, title, adminId, themeId, type, sources];
}
