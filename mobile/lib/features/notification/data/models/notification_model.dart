import 'package:theft_detecting_system/features/notification/domain/entities/notification.dart';

class NotificationModel extends Notification {
  const NotificationModel({
    required super.id,
    required super.title,
    required super.description,
    required super.timestamp,
    required super.isRead,
    super.videoUrl,
    super.thumbnailUrl,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      timestamp: DateTime.parse(json['timestamp']),
      isRead: json['isRead'] ?? false,
      videoUrl: json['videoUrl'],
      thumbnailUrl: json['thumbnailUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'timestamp': timestamp.toIso8601String(),
      'isRead': isRead,
      'videoUrl': videoUrl,
      'thumbnailUrl': thumbnailUrl,
    };
  }
}
