import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:grizz_connect/profile.dart';

class profileInfo extends StatefulWidget {
  const profileInfo({Key? key}) : super(key: key);


  @override
  _profileInfoState createState() => _profileInfoState();
}

class _profileInfoState extends State<profileInfo> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final user = _auth.currentUser;
    final userid = user!.uid.toString();
    final userEmail = user.email.toString();
    var userName = '';
    var major = '';
    var standing = '';
    //print('user id is: '+userid);
    //print('user email is: '+ userEmail);
    //print('display name is: '+ userName.toString());

    final userdata = Provider.of<QuerySnapshot>(context);

    List<String> records = [];

    for (var doc in userdata.docs) {
      if(doc.id == userid) {
        records = [doc.get('displayName'),
          doc.get('major'),
          doc.get('standing')];
        userName = records[0];
        major = records[1];
        standing = records[2];

        //print(doc.data()); //get all data as a set
      }
    }
    //for(int i = 0; i<records.length; i++) {
    //  print(records[i]);
    //}
    //records.map((record) {
    //  return print(record);
    //}).toList();
    records.map((e) => print(e)).toList();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme
              .of(context)
              .scaffoldBackgroundColor,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.yellow,
            ),
            onPressed: () {},
          ),

        ),

        body: Container( //begin container

          padding: EdgeInsets.only(left: 16, top: 25, right: 16),
          child: ListView(//listView
            children: [// child
              Text(
                "Profile Page",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
              ),
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                    child: CircleAvatar(
                      radius: 71,
                      child: CircleAvatar(
                        radius: 65,

                      ),
                    ),
                  ),
                  Positioned(
                      top: 120,
                      left: 120,
                      child: RawMaterialButton(
                        elevation: 10,
                        child: Icon(Icons.add_a_photo),
                        padding: EdgeInsets.all(15.0),
                        shape: CircleBorder(),
                        onPressed: () {
                          showDialog(context: context, builder: (BuildContext context){
                            return AlertDialog(
                              title: Text(
                                'Choose Profile Photo',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.yellow,
                                ),
                              ),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: [
                                    InkWell(
                                      onDoubleTap: () {},
                                      splashColor: Colors.yellow,
                                      child: Row(
                                        children: const [
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.camera,
                                              color: Colors.yellow,
                                            ),
                                          ),
                                          Text(
                                              'Camera',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              )
                                          ),

                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      splashColor: Colors.yellow,
                                      child: Row(
                                        children: const [
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.image,
                                              color: Colors.yellow,
                                            ),
                                          ),
                                          Text(
                                              'Gallery',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,

                                              )

                                          ),

                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ),

                            );
                          });
                        },


                      ))
                ],
              ),


              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlineButton(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20) ),
                    onPressed: () {},
                    child: Text("CANCLE",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.black)),
                  ),
                  RaisedButton(
                    onPressed: () {},
                    color: Colors.yellow,
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    child: Text("SAVE", style: TextStyle(
                        fontSize: 14,
                        letterSpacing: 2.2,
                        color: Colors.white),
                    ),
                  )
                ],
              )
            ],
          ),
        )
    );
  }
}