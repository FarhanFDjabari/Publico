import 'package:equatable/equatable.dart';

class VideoSingkat extends Equatable {
  final String id;
  final String title;
  final String description;
  final String videoUrl;
  final String tiktokUrl;

  const VideoSingkat({
    required this.id,
    required this.title,
    required this.description,
    required this.videoUrl,
    required this.tiktokUrl,
  });
  @override
  List<Object?> get props => [
        id,
        title,
        description,
        videoUrl,
        tiktokUrl,
      ];
}
