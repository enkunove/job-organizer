import 'package:test_task/feature/data/models/notification_model.dart';

import '../../domain/entities/notification.dart';
import '../../domain/repositories/notifications_repository.dart';
import '../datasources/local/notifications_datasource.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  final NotificationsDatasource notificationsDatasource;

  NotificationsRepositoryImpl({required this.notificationsDatasource});

  @override
  Future<void> requestPermissions() => notificationsDatasource.requestPermissions();

  @override
  Future<void> scheduleNotification(Notification notification) {
    final model = NotificationModel(id: notification.id, title: notification.title, body: notification.body, scheduledTime: notification.scheduledTime);
    return notificationsDatasource.scheduleNotification(model);
  }
}
