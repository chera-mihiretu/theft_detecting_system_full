import 'package:equatable/equatable.dart';

class VideoStream extends Equatable {
  final String id;
  final String url;
  final String title;
  final DateTime timestamp;
  final bool isLive;
  final String? thumbnailUrl;

  const VideoStream({
    required this.id,
    required this.url,
    required this.title,
    required this.timestamp,
    required this.isLive,
    this.thumbnailUrl,
  });

  @override
  List<Object?> get props => [id, url, title, timestamp, isLive, thumbnailUrl];
}
