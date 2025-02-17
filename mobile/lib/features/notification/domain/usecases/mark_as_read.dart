import 'package:theft_detecting_system/features/notification/domain/repositories/notification_repository.dart';

class MarkAsRead {
  final NotificationRepository repository;

  MarkAsRead(this.repository);

  Future<void> call(String notificationId) async {
    await repository.markAsRead(notificationId);
  }
}
