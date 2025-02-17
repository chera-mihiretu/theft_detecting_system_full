import 'package:theft_detecting_system/features/notification/data/datasources/notification_remote_datasource.dart';
import 'package:theft_detecting_system/features/notification/domain/entities/notification.dart';
import 'package:theft_detecting_system/features/notification/domain/repositories/notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource remoteDataSource;

  NotificationRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Notification>> getNotifications() async {
    return await remoteDataSource.getNotifications();
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    await remoteDataSource.markAsRead(notificationId);
  }

  @override
  Future<void> deleteNotification(String notificationId) async {
    await remoteDataSource.deleteNotification(notificationId);
  }
}
