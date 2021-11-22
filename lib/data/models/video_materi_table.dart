import 'package:equatable/equatable.dart';
import 'package:publico/data/models/video_materi_model.dart';
import 'package:publico/domain/entities/video_materi.dart';

class VideoMateriTable extends Equatable {
  final String id;
  final String adminId;
  final String title;
  final String description;
  final int duration;
  final String type;
  final String thumbnailUrl;
  final String videoUrl;

  const VideoMateriTable(
      {required this.id,
      required this.adminId,
      required this.title,
      required this.description,
      required this.duration,
      required this.type,
      required this.thumbnailUrl,
      required this.videoUrl});

  factory VideoMateriTable.fromEntity(VideoMateri videoMateri) =>
      VideoMateriTable(
        id: videoMateri.id,
        adminId: videoMateri.adminId,
        title: videoMateri.title,
        description: videoMateri.description,
        duration: videoMateri.duration,
        type: videoMateri.type,
        thumbnailUrl: videoMateri.thumbnailUrl,
        videoUrl: videoMateri.videoUrl,
      );

  factory VideoMateriTable.fromMap(Map<String, dynamic> map) =>
      VideoMateriTable(
        id: map['id'],
        adminId: map['admin_id'],
        title: map['title'],
        description: map['description'],
        duration: map['duration'],
        type: map['type'],
        thumbnailUrl: map['thumbnail_url'],
        videoUrl: map['video_url'],
      );

  factory VideoMateriTable.fromDTO(VideoMateriModel videoMateriModel) =>
      VideoMateriTable(
        id: videoMateriModel.id,
        adminId: videoMateriModel.adminId,
        title: videoMateriModel.title,
        description: videoMateriModel.description,
        duration: videoMateriModel.duration,
        type: videoMateriModel.type,
        thumbnailUrl: videoMateriModel.thumbnailUrl,
        videoUrl: videoMateriModel.videoUrl,
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
      };

  VideoMateri toEntity() => VideoMateri.bookmark(
        id: id,
        adminId: adminId,
        type: type,
        title: title,
        duration: duration,
        description: description,
        videoUrl: videoUrl,
        thumbnailUrl: thumbnailUrl,
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
      ];
}
