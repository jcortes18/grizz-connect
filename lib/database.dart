import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ required this.uid });

  // collection reference
  final CollectionReference data = FirebaseFirestore.instance.collection('data');
  final CollectionReference comments = FirebaseFirestore.instance.collection('comments');

  Future updateUserData(String displayName, String major, String standing) async {
    return await data.doc(uid).set({
      'displayName': displayName,
      'major': major,
      'standing': standing,

    });
  }

  Future updateComments(String comment) async {
    final snapShot = await FirebaseFirestore.instance
        .collection('comments')
        .doc(uid)
        .get();

    if (snapShot == null || !snapShot.exists) {
      FirebaseFirestore.instance.collection("comments").doc(uid).set({
        //"uid": uid,
      });
      return await comments.doc(uid).collection("comments").doc().set({
        'comment': comment,
      });
    }
    else {
      return await comments.doc(uid).collection("comments").doc().set({
        'comment': comment,
      });
    }
  }

  Stream<QuerySnapshot> get userData {
    return data.snapshots();
  }
}