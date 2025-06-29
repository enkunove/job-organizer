import 'package:test_task/feature/domain/entities/notification.dart';

class NotificationModel extends Notification {
  NotificationModel({
    required super.id,
    required super.title,
    required super.body,
    required super.scheduledTime,
  });
}
