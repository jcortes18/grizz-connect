import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ required this.uid });

  // collection reference
  final CollectionReference data = FirebaseFirestore.instance.collection('data');
  final CollectionReference comments = FirebaseFirestore.instance.collection('comments');

  Future updateUserData(String displayName, String major, String standing, String url) async {
    return await data.doc(uid).set({
      'displayName': displayName,
      'major': major,
      'standing': standing,
      'imageUrl': url,
    });
  }

  Stream<QuerySnapshot> get userData {
      return data.snapshots();
  }
/*  final CollectionReference pics = FirebaseFirestore.instance.collection('images');

  Future updateUserpics(String imageUrl, String userId) async {
    return await pics.doc(uid).set({
      'imageUrl': imageUrl,
      'userId': userId,
    });
  }
  Stream<QuerySnapshot> get userpics {
    return pics.snapshots();
  }

 */ //ignore

  Future updateComments(String comment, name, email) async {
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
        'name' : name,
        'email' : email,
      });
    }
    else {
      return await comments.doc(uid).collection("comments").doc().set({
        'comment': comment,
        'name' : name,
        'email' : email,
      });
    }
  }
}