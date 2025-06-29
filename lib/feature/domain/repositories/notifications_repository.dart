import '../entities/notification.dart';

abstract class NotificationsRepository {
  Future<void> requestPermissions();
  Future<void> scheduleNotification(Notification notification);
}
