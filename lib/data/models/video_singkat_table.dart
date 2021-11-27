import 'package:equatable/equatable.dart';
import 'package:publico/data/models/video_singkat_model.dart';
import 'package:publico/domain/entities/video_singkat.dart';

class VideoSingkatTable extends Equatable {
  final String id;
  final String adminId;
  final String title;
  final String description;
  final int duration;
  final String type;
  final String thumbnailUrl;
  final String videoUrl;
  final String tiktokUrl;

  const VideoSingkatTable(
      {required this.id,
      required this.adminId,
      required this.title,
      required this.description,
      required this.duration,
      required this.type,
      required this.thumbnailUrl,
      required this.videoUrl,
      required this.tiktokUrl});

  factory VideoSingkatTable.fromEntity(VideoSingkat videoSingkat) =>
      VideoSingkatTable(
        id: videoSingkat.id,
        adminId: videoSingkat.adminId,
        title: videoSingkat.title,
        description: videoSingkat.description,
        duration: videoSingkat.duration,
        type: videoSingkat.type,
        thumbnailUrl: videoSingkat.thumbnailUrl,
        videoUrl: videoSingkat.videoUrl,
        tiktokUrl: videoSingkat.tiktokUrl,
      );

  factory VideoSingkatTable.fromMap(Map<String, dynamic> map) =>
      VideoSingkatTable(
        id: map['id'],
        adminId: map['admin_id'],
        title: map['title'],
        description: map['description'],
        duration: map['duration'],
        type: map['type'],
        thumbnailUrl: map['thumbnail_url'],
        videoUrl: map['video_url'],
        tiktokUrl: map['tiktok_url'],
      );

  factory VideoSingkatTable.fromDTO(VideoSingkatModel videoSingkatModel) =>
      VideoSingkatTable(
        id: videoSingkatModel.id,
        adminId: videoSingkatModel.adminId,
        title: videoSingkatModel.title,
        description: videoSingkatModel.description,
        duration: videoSingkatModel.duration,
        type: videoSingkatModel.type,
        thumbnailUrl: videoSingkatModel.thumbnailUrl,
        videoUrl: videoSingkatModel.videoUrl,
        tiktokUrl: videoSingkatModel.tiktokUrl,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'admin_id': adminId,
        'title': title,
        'description': description,
        'duration': duration,
        'type': type,
        'thumbnail_url': thumbnailUrl,
        'video_url': videoUrl,
        'tiktok_url': tiktokUrl,
      };

  VideoSingkat toEntity() => VideoSingkat.bookmark(
        id: id,
        adminId: adminId,
        type: type,
        title: title,
        duration: duration,
        bookmarkCount: 0,
        description: description,
        videoUrl: videoUrl,
        thumbnailUrl: thumbnailUrl,
        tiktokUrl: tiktokUrl,
      );

  @override
  List<Object?> get props => [
        id,
        adminId,
        title,
        description,
        duration,
        type,
        thumbnailUrl,
        videoUrl,
        tiktokUrl,
      ];
}
