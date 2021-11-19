import 'package:equatable/equatable.dart';
import 'package:publico/domain/entities/video_materi.dart';

class VideoMateriModel extends Equatable {
  final String id;
  final String type;
  final String title;
  final int duration;
  final String description;
  final String videoUrl;
  final String thumbnailUrl;

  const VideoMateriModel({
    required this.id,
    required this.type,
    required this.title,
    required this.duration,
    required this.description,
    required this.videoUrl,
    required this.thumbnailUrl,
  });

  VideoMateri toEntity() {
    return VideoMateri(
      id: id,
      type: type,
      title: title,
      duration: duration,
      description: description,
      videoUrl: videoUrl,
      thumbnailUrl: thumbnailUrl,
    );
  }

  @override
  List<Object?> get props => [
        id,
        type,
        title,
        duration,
        description,
        videoUrl,
        thumbnailUrl,
      ];
}
