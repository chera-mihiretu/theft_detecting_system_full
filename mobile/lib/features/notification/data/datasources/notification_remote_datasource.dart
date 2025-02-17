import 'package:dio/dio.dart';
import 'package:theft_detecting_system/config/environment.dart';
import 'package:theft_detecting_system/features/notification/domain/entities/notification.dart';

abstract class NotificationRemoteDataSource {
  Future<List<Notification>> getNotifications();
  Future<void> markAsRead(String notificationId);
  Future<void> deleteNotification(String notificationId);
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final Dio _dio;

  NotificationRemoteDataSourceImpl({Dio? dio}) : _dio = dio ?? Dio();

  @override
  Future<List<Notification>> getNotifications() async {
    try {
      final response = await _dio.get(Environment.notificationApiUrl);
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => Notification(
          id: json['id'] ?? '',
          title: json['title'] ?? 'Motion Detected',
          description: json['description'] ?? 'Motion detected at ${DateTime.now()}',
          timestamp: DateTime.parse(json['timestamp'] ?? DateTime.now().toIso8601String()),
          isRead: json['isRead'] ?? false,
          videoUrl: json['videoUrl'],
          thumbnailUrl: json['thumbnailUrl'],
        )).toList();
      } else {
        throw Exception('Failed to get notifications: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to get notifications: $e');
    }
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    try {
      await _dio.patch('${Environment.notificationApiUrl}/$notificationId/read');
    } catch (e) {
      throw Exception('Failed to mark notification as read: $e');
    }
  }

  @override
  Future<void> deleteNotification(String notificationId) async {
    try {
      await _dio.delete('${Environment.notificationApiUrl}/$notificationId');
    } catch (e) {
      throw Exception('Failed to delete notification: $e');
    }
  }
}
