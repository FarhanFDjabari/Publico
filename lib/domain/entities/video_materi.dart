import 'package:equatable/equatable.dart';

class VideoMateri extends Equatable {
  final String id;
  final String adminId;
  final String type;
  final String title;
  final int duration;
  final String description;
  final String videoUrl;
  final String thumbnailUrl;

  const VideoMateri({
    required this.id,
    required this.adminId,
    required this.type,
    required this.title,
    required this.duration,
    required this.description,
    required this.videoUrl,
    required this.thumbnailUrl,
  });

  const VideoMateri.bookmark({
    required this.id,
    required this.adminId,
    required this.type,
    required this.title,
    required this.duration,
    required this.description,
    required this.videoUrl,
    required this.thumbnailUrl,
  });

  @override
  List<Object?> get props => [
        id,
        adminId,
        type,
        title,
        duration,
        description,
        videoUrl,
        thumbnailUrl,
      ];
}
