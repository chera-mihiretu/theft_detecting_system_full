import 'package:theft_detecting_system/features/notification/domain/repositories/notification_repository.dart';

class DeleteNotification {
  final NotificationRepository repository;

  DeleteNotification(this.repository);

  Future<void> call(String notificationId) async {
    await repository.deleteNotification(notificationId);
  }
}
