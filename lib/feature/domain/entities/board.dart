class Board {
  final String? id;
  final String ownerId;
  final String title;
  final String colorHex;
  final String? description;
  final DateTime createdAt;
  final DateTime lastUpdate;
  final bool isArchived;

  Board({
    this.id,
    required this.ownerId,
    required this.title,
    required this.colorHex,
    required this.description,
    required this.createdAt,
    required this.lastUpdate,
    required this.isArchived,
  });
}
