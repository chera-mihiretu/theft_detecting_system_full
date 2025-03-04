import 'package:theft_detecting_system/features/home/domain/entities/video_stream.dart';

class VideoStreamModel extends VideoStream {
  const VideoStreamModel({
    required super.id,
    required super.url,
    required super.title,
    required super.timestamp,
    required super.isLive,
    super.thumbnailUrl,
  });

  factory VideoStreamModel.fromJson(Map<String, dynamic> json) {
    return VideoStreamModel(
      id: json['id'],
      url: json['url'],
      title: json['title'],
      timestamp: DateTime.parse(json['timestamp']),
      isLive: json['isLive'],
      thumbnailUrl: json['thumbnailUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
      'title': title,
      'timestamp': timestamp.toIso8601String(),
      'isLive': isLive,
      'thumbnailUrl': thumbnailUrl,
    };
  }
}
