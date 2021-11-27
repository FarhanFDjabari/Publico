import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:publico/domain/entities/video_singkat.dart';

class VideoSingkatModel extends Equatable {
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

  const VideoSingkatModel({
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

  static VideoSingkatModel fromSnapshot(DocumentSnapshot snapshot) {
    return VideoSingkatModel(
      id: snapshot.id,
      adminId: snapshot['admin_id'],
      type: snapshot['type'],
      title: snapshot['title'],
      duration: snapshot['duration'],
      bookmarkCount: snapshot['bookmark_count'],
      description: snapshot['description'],
      videoUrl: snapshot['video_url'],
      thumbnailUrl: snapshot['thumbnail_url'],
      tiktokUrl: snapshot['tiktok_url'],
    );
  }

  VideoSingkat toEntity() {
    return VideoSingkat(
      id: id,
      adminId: adminId,
      type: type,
      title: title,
      duration: duration,
      bookmarkCount: bookmarkCount,
      description: description,
      videoUrl: videoUrl,
      thumbnailUrl: thumbnailUrl,
      tiktokUrl: tiktokUrl,
    );
  }

  @override
  List<Object?> get props => [
        id,
        adminId,
        type,
        title,
        duration,
        bookmarkCount,
        description,
        videoUrl,
        thumbnailUrl,
        tiktokUrl,
      ];
}
