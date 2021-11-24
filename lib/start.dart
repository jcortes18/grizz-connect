import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grizz_connect/user_list.dart';
import 'package:grizz_connect/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyStart extends StatefulWidget {
  const MyStart({Key? key}) : super(key: key);


  @override
  _MyStartState createState() => _MyStartState();

}

class _MyStartState extends State<MyStart> {

  final FirebaseAuth auth = FirebaseAuth.instance;

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {  //start widget

    return StreamProvider<QuerySnapshot?>.value(
      //startstream
      value: DatabaseService(uid: '').userData,
      initialData: null,


      child: Scaffold(

        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          backgroundColor: Colors.amberAccent[400],

          actions: <Widget>[
            TextButton.icon(
              icon: const Icon(Icons.person,
                color: Colors.black,
                size: 32,
              ),

              label: const Text('Logout',
                style: TextStyle(color: Colors.black, fontSize: 20),

              ),

              onPressed: () => Navigator.pushNamed(context, 'login'),
            ),
            IconButton(
              icon: const Icon(
                Icons.home,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pushNamed(context, 'welcome');
              },
            ),
          ],
        ),

        body:
        profileInfo()

      ),
    );
  }
}