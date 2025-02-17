import 'package:equatable/equatable.dart';

class Notification extends Equatable {
  final String id;
  final String title;
  final String description;
  final DateTime timestamp;
  final bool isRead;
  final String? videoUrl;
  final String? thumbnailUrl;

  const Notification({
    required this.id,
    required this.title,
    required this.description,
    required this.timestamp,
    required this.isRead,
    this.videoUrl,
    this.thumbnailUrl,
  });

  @override
  List<Object?> get props => [id, title, description, timestamp, isRead, videoUrl, thumbnailUrl];
}
