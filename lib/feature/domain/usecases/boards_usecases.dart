import 'package:firebase_auth/firebase_auth.dart';
import '../repositories/boards_repository.dart';
import '../entities/board.dart';

class BoardsUsecases {
  final BoardsRepository repository;
  final FirebaseAuth auth;

  BoardsUsecases({required this.repository, FirebaseAuth? firebaseAuth})
      : auth = firebaseAuth ?? FirebaseAuth.instance;

  Future<void> createBoard({
    required String title,
    required String? description,
    required String colorHex,
  }) {
    final now = DateTime.now();
    final ownerId = auth.currentUser?.uid;
    if (ownerId == null) throw Exception();
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

  Future<void> updateBoard(Board board) async {
    return repository.updateBoard(board.copyWith(lastUpdate: DateTime.now()));
  }

  Future<List<Board>> getBoards() async {
    final uid = auth.currentUser?.uid;
    if (uid == null) throw Exception();
    return repository.getBoardsByOwner(uid);
  }

  Future<Board> getBoardById(String boardId) {
    return repository.getBoardById(boardId);
  }
}
