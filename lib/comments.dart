import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:timeago/timeago.dart' as timeago;

final commentsRef = FirebaseFirestore.instance.collection('comments');
final usersRef = FirebaseFirestore.instance.collection('data');
final DateTime timestamp = DateTime.now();
class Comments extends StatefulWidget {
  final String itemId;
  final String postOwnerId;


  Comments({
    required this.itemId,
    required this.postOwnerId,
  });


  @override
  CommentsState createState() => CommentsState<>(
    itemId: this.itemId,
    postOwnerId: this.postOwnerId,
 );
}

class CommentsState extends State<Comments> {
  TextEditingController commentController = TextEditingController();
  final String itemId;
  final String postOwnerId;

  CommentsState({
    required this.itemId,
    required this.postOwnerId,
]  });

  buildComments() {
    return StreamBuilder(
        stream: commentsRef
            .document(itemId)
            .collection('comments')
            .orderBy("timestamp", descending: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
          }
          List<Comment> comments = [];
          snapshot.data!.documents.forEach((doc) {
            comments.add(Comment.fromDocument(doc));
          });
          return ListView(
            children: comments,
          );
        });
  }

  addComment() {
    commentsRef.document(itemId).collection("comments").add({
      "username": currentUser.username,
      "comment": commentController.text,
      "timestamp": timestamp,
      "userId": currentUser.id,
    });
    bool isNotPostOwner = postOwnerId != currentUser.id;
    if (isNotPostOwner) {
      activityFeedRef.document(postOwnerId).collection('feedItems').add({
        "type": "comment",
        "commentData": commentController.text,
        "timestamp": timestamp,
        "itemId": itemId,
        "userId": user.id,
        "username": currentUser.username,
        "mediaUrl": postMediaUrl,
      });
    }
    commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final user = _auth.currentUser;
    final userid = user!.uid.toString();
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color.fromRGBO(47, 46, 46, 1.0),
          centerTitle: true,
          title: const Text(
            'Comments',
          )),
      body: Column(
        children: <Widget>[
          Expanded(child: buildComments()),
          Divider(),
          ListTile(
            title: TextFormField(
              controller: commentController,
              decoration: InputDecoration(labelText: "Write a comment..."),
            ),
            trailing: OutlineButton(
              onPressed: addComment,
              borderSide: BorderSide.none,
              child: Text("Post"),
            ),
          ),
        ],
      ),
    );
  }
}

class Comment extends StatelessWidget {
  final String username;
  final String userId;
  final String comment;
  final Timestamp timestamp;

  Comment({
    required this.username,
    required this.userId,
    required this.comment,
    required this.timestamp,
  });

  factory Comment.fromDocument(DocumentSnapshot doc) {
    return Comment(
      username: doc['username'],
      userId: doc['userId'],
      comment: doc['comment'],
      timestamp: doc['timestamp'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(comment),
          leading: CircleAvatar(
          ),
          subtitle: Text(timeago.format(timestamp.toDate())),
        ),
        Divider(),
      ],
    );
  }
}
