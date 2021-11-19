import 'package:equatable/equatable.dart';

class VideoSingkat extends Equatable {
  final String id;
  final String type;
  final String title;
  final int duration;
  final String description;
  final String videoUrl;
  final String thumbnailUrl;
  final String tiktokUrl;

  const VideoSingkat({
    required this.id,
    required this.type,
    required this.title,
    required this.duration,
    required this.description,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.tiktokUrl,
  });
  @override
  List<Object?> get props => [
        id,
        type,
        title,
        duration,
        thumbnailUrl,
        description,
        videoUrl,
        tiktokUrl,
      ];
}
