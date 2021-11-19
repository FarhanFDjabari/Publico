import 'package:equatable/equatable.dart';

class VideoMateri extends Equatable {
  final String id;
  final String type;
  final String title;
  final String description;
  final String videoUrl;

  const VideoMateri({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.videoUrl,
  });

  @override
  List<Object?> get props => [
        id,
        type,
        title,
        description,
        videoUrl,
      ];
}
