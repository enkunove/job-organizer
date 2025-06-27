import 'package:cloud_firestore/cloud_firestore.dart';

class BoardsDatasource {
    final FirebaseFirestore _firestore;

    BoardsDatasource({FirebaseFirestore? firestore})
        : _firestore = firestore ?? FirebaseFirestore.instance;

    Future<void> createBoard(Map<String, dynamic> map) async {
        final collection = _firestore.collection('boards');
        final id = map['id'] ?? collection.doc().id;

        try {
          await collection.doc(id).set(map);
        } on FirebaseException catch (e) {
          print(e.message);
        }
    }

    Future<List<Map<String, dynamic>>> getBoardsByOwner(String ownerId) async {
        try {
            final querySnapshot = await _firestore
                .collection('boards')
                .where('ownerId', isEqualTo: ownerId)
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
