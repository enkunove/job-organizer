import 'package:firebase_auth/firebase_auth.dart';

import '../repositories/boards_repository.dart';
import '../entities/board.dart';

class BoardsUsecases {
  final BoardsRepository repository;

  BoardsUsecases({required this.repository});

  Future<void> createBoard({
    required String title,
    required String? description,
    required String colorHex,
  }) {
    final now = DateTime.now();
    final ownerId = FirebaseAuth.instance.currentUser?.uid;
    if (ownerId == null){
      throw Exception();
    }
    final board = Board(
      ownerId: ownerId,
      title: title,
      colorHex: colorHex,
      description: description,
      createdAt: now,
      lastUpdate: now,
      isArchived: false,
    );

    return repository.createBoard(board);
  }

  Future<List<Board>> getBoards() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null){
      throw Exception();
    }
    return await repository.getBoardsByOwner(uid);
  }

}
