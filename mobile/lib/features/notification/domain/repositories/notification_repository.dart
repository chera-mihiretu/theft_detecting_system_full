import 'package:theft_detecting_system/features/notification/domain/entities/notification.dart';

abstract class NotificationRepository {
  Future<List<Notification>> getNotifications();
  Future<void> markAsRead(String notificationId);
  Future<void> deleteNotification(String notificationId);
}
