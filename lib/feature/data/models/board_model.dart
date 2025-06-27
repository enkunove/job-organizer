import 'package:test_task/feature/domain/entities/board.dart';

class BoardModel extends Board {
  BoardModel({
    required super.id,
    required super.ownerId,
    required super.title,
    required super.colorHex,
    required super.description,
    required super.createdAt,
    required super.lastUpdate,
    required super.isArchived,
  });

  factory BoardModel.fromMap(Map<String, dynamic> map) {
    return BoardModel(
      id: map['id'] as String?,
      ownerId: map['ownerId'] as String,
      title: map['title'] as String,
      colorHex: map['colorHex'] as String,
      description: map['description'] as String?,
      createdAt: DateTime.parse(map['createdAt'] as String),
      lastUpdate: DateTime.parse(map['lastUpdate'] as String),
      isArchived: map['isArchived'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ownerId': ownerId,
      'title': title,
      'colorHex': colorHex,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'lastUpdate': lastUpdate.toIso8601String(),
      'isArchived': isArchived,
    };
  }
}
