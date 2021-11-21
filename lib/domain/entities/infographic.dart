import 'package:equatable/equatable.dart';

class Infographic extends Equatable {
  final String id;
  final String title;
  final String adminId;
  final String themeId;
  final String themeName;
  final List<dynamic> sources;

  const Infographic({
    required this.id,
    required this.title,
    required this.adminId,
    required this.themeId,
    required this.themeName,
    required this.sources,
  });

  @override
  List<Object?> get props => [id, title, adminId, themeId, sources];
}
