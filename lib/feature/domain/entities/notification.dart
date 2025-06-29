class Notification {
  final int id;
  final String title;
  final String body;
  final DateTime scheduledTime;

  Notification({
    required this.id,
    required this.title,
    required this.body,
    required this.scheduledTime,
  });
}
