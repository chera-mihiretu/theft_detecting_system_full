import 'package:flutter/foundation.dart';
import 'package:theft_detecting_system/features/notification/domain/entities/notification.dart';
import 'package:theft_detecting_system/features/notification/domain/usecases/delete_notification.dart';
import 'package:theft_detecting_system/features/notification/domain/usecases/get_notifications.dart';
import 'package:theft_detecting_system/features/notification/domain/usecases/mark_as_read.dart';

class NotificationProvider extends ChangeNotifier {
  final GetNotifications _getNotifications;
  final MarkAsRead _markAsRead;
  final DeleteNotification _deleteNotification;

  NotificationProvider({
    required GetNotifications getNotifications,
    required MarkAsRead markAsRead,
    required DeleteNotification deleteNotification,
  })  : _getNotifications = getNotifications,
        _markAsRead = markAsRead,
        _deleteNotification = deleteNotification;

  List<Notification> _notifications = [];
  bool _isLoading = false;
  String? _error;

  List<Notification> get notifications => _notifications;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadNotifications() async {
    _setLoading(true);
    _clearError();

    try {
      _notifications = await _getNotifications();
      notifyListeners();
    } catch (e) {
      _setError('Failed to load notifications: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> markAsRead(String notificationId) async {
    _setLoading(true);
    _clearError();

    try {
      await _markAsRead(notificationId);
      
      // Update local state
      final index = _notifications.indexWhere((n) => n.id == notificationId);
      if (index != -1) {
        _notifications[index] = Notification(
          id: _notifications[index].id,
          title: _notifications[index].title,
          description: _notifications[index].description,
          timestamp: _notifications[index].timestamp,
          isRead: true,
          videoUrl: _notifications[index].videoUrl,
          thumbnailUrl: _notifications[index].thumbnailUrl,
        );
        notifyListeners();
      }
    } catch (e) {
      _setError('Failed to mark notification as read: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> deleteNotification(String notificationId) async {
    _setLoading(true);
    _clearError();

    try {
      await _deleteNotification(notificationId);
      
      // Update local state
      _notifications.removeWhere((n) => n.id == notificationId);
      notifyListeners();
    } catch (e) {
      _setError('Failed to delete notification: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _error = error;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
    notifyListeners();
  }
}
