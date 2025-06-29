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

  Board copyWith({
    String? id,
    String? ownerId,
    String? title,
    DateTime? createdAt,
    DateTime? lastUpdate,
    String? colorHex,
    bool? isArchived,
    String? boardId,
    String? description,
  }) {
    return Board(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      lastUpdate: lastUpdate ?? this.lastUpdate,
      colorHex: colorHex ?? this.colorHex,
      isArchived: isArchived ?? this.isArchived,
      description: description ?? this.description
    );
  }
}
