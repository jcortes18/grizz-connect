import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ required this.uid });

  // collection reference
  final CollectionReference data = FirebaseFirestore.instance.collection('data');

  Future updateUserData(String displayName, String major, String standing) async {
    return await data.doc(uid).set({
      'displayName': displayName,
      'major': major,
      'standing': standing,

    });
  }

  Stream<QuerySnapshot> get userData {
      return data.snapshots();
  }
}