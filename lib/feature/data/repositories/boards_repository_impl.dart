import 'package:test_task/feature/data/datasources/remote/boards_datasource.dart';
import 'package:test_task/feature/data/models/board_model.dart';
import 'package:test_task/feature/domain/entities/board.dart';
import 'package:test_task/feature/domain/repositories/boards_repository.dart';

class BoardsRepositoryImpl implements BoardsRepository{

  final BoardsDatasource datasource;

  BoardsRepositoryImpl({required this.datasource});

  @override
  Future<void> createBoard(Board board) async {
    final BoardModel model = BoardModel(
      id: board.id,
      ownerId: board.ownerId,
      title: board.title,
      colorHex: board.colorHex,
      description: board.description,
      createdAt: board.createdAt,
      lastUpdate: board.lastUpdate,
      isArchived: board.isArchived,
    );
    return await datasource.createBoard(model.toMap());

  }

  @override
  Future<void> updateBoard(Board board) async {
    final BoardModel model = BoardModel(
      id: board.id,
      ownerId: board.ownerId,
      title: board.title,
      colorHex: board.colorHex,
      description: board.description,
      createdAt: board.createdAt,
      lastUpdate: board.lastUpdate,
      isArchived: board.isArchived,
    );
    return await datasource.updateBoard(model.toMap());

  }

  @override
  Future<List<BoardModel>> getBoardsByOwner(String ownerId) async {
    final List<Map<String, dynamic>> boardsMaps = await datasource.getBoardsByOwner(ownerId);

    return boardsMaps.map((map) => BoardModel.fromMap(map)).toList();
  }
  @override
  Future<BoardModel> getBoardById(String boardId) async{
    final map = await datasource.getBoardById(boardId);
    return BoardModel.fromMap(map);
  }


}