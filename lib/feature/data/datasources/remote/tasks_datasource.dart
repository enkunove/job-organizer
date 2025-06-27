import 'package:cloud_firestore/cloud_firestore.dart';

class TasksDatasource{
  final FirebaseFirestore _firestore;

  TasksDatasource({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> createTask(Map<String, dynamic> map) async {
    final collection = _firestore.collection('tasks');
    final id = map['id'] ?? collection.doc().id;

    try {
      await collection.doc(id).set(map);
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }

  Future<List<Map<String, dynamic>>> getTasksForBoardByBoardId(String boardId) async {
    try {
      final querySnapshot = await _firestore
          .collection('tasks')
          .where('boardId', isEqualTo: boardId)
          .get();

      final res = querySnapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();

      print(res);
      return res;
    } on FirebaseException catch (e) {
      print(e.message);
      return [];
    }
  }
}