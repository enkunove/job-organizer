import 'package:test_task/feature/domain/entities/board.dart';

abstract class BoardsRepository{
  Future<void> createBoard(Board board);
  Future<List<Board>> getBoardsByOwner(String ownerId);
  Future<Board> getBoardById(String boardId);

}