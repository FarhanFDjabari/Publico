import 'package:equatable/equatable.dart';
import 'package:publico/domain/entities/video_materi.dart';

class VideoMateriModel extends Equatable {
  final String id;
  final String type;
  final String title;
  final String description;
  final String videoUrl;

  const VideoMateriModel({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.videoUrl,
  });

  VideoMateri toEntity() {
    return VideoMateri(
      id: id,
      type: type,
      title: title,
      description: description,
      videoUrl: videoUrl,
    );
  }

  @override
  List<Object?> get props => [
        id,
        type,
        title,
        description,
        videoUrl,
      ];
}
