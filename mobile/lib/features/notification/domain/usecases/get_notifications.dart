import 'package:theft_detecting_system/features/notification/domain/entities/notification.dart';
import 'package:theft_detecting_system/features/notification/domain/repositories/notification_repository.dart';

class GetNotifications {
  final NotificationRepository repository;

  GetNotifications(this.repository);

  Future<List<Notification>> call() async {
    return await repository.getNotifications();
  }
}
