import 'package:equatable/equatable.dart';

class VideoSingkat extends Equatable {
  final String id;
  final String adminId;
  final String type;
  final String title;
  final int duration;
  final int bookmarkCount;
  final String description;
  final String videoUrl;
  final String thumbnailUrl;
  final String tiktokUrl;

  const VideoSingkat({
    required this.id,
    required this.adminId,
    required this.type,
    required this.title,
    required this.duration,
    required this.bookmarkCount,
    required this.description,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.tiktokUrl,
  });

  const VideoSingkat.bookmark({
    required this.id,
    required this.adminId,
    required this.type,
    required this.title,
    required this.duration,
    required this.bookmarkCount,
    required this.description,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.tiktokUrl,
  });

  @override
  List<Object?> get props => [
        id,
        adminId,
        type,
        title,
        duration,
        bookmarkCount,
        thumbnailUrl,
        description,
        videoUrl,
        tiktokUrl,
      ];
}
