import 'package:equatable/equatable.dart';
import 'package:publico/domain/entities/video_singkat.dart';

class VideoSingkatModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final String videoUrl;
  final String tiktokUrl;

  const VideoSingkatModel({
    required this.id,
    required this.title,
    required this.description,
    required this.videoUrl,
    required this.tiktokUrl,
  });

  VideoSingkat toEntity() {
    return VideoSingkat(
      id: id,
      title: title,
      description: description,
      videoUrl: videoUrl,
      tiktokUrl: tiktokUrl,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        videoUrl,
        tiktokUrl,
      ];
}
