import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class profileInfo extends StatefulWidget {
  const profileInfo({Key? key}) : super(key: key);
  @override
  _profileInfoState createState() => _profileInfoState();
}

class _profileInfoState extends State<profileInfo> {
  File? imageFile;
  double dimention = 200;

  void _getFromGallery() async{
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 150,
      maxWidth: 150,
    );
    setState(() {
      imageFile = File(pickedFile!.path);
    });
  }

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
        user.updateDisplayName(doc.get('displayName'));
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
//records.map((e) => print(e)).toList();

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('Profile.jpg'), fit: BoxFit.fill
        ),
      ),
        child: Scaffold(
            backgroundColor: Colors.black12,

      body: Stack(

      children: [
      Column(
        children: [
          Container(padding: const EdgeInsets.fromLTRB(0, 20, 0, 20), ),
          Container(
          child: Center( child: Stack(
              children: [
            Positioned(top: 0, left: 0, bottom: 0, right: 0, child: Container(
               //alignment: Alignment.center,
                child:CircleAvatar(
                  radius: dimention, backgroundColor: Colors.transparent,
                  child: ClipOval(
                      child: SizedBox(
                        width: dimention, height: dimention,
                        child:(imageFile!=null)?Image.file(File(imageFile!.path),fit: BoxFit.fill)
                            :
                        Container(child: Icon(Icons.person_rounded, color: Colors.white, size: MediaQuery.of(context).size.width * .4,),
                        ),//camera_enhance_rounded
                      )
                  ),
                ),

            )),
            Container(
          width: dimention, height: dimention, decoration: BoxDecoration(
          border: Border.all(width: 4, color: Colors.amber),
          boxShadow: [ BoxShadow(spreadRadius: 20, blurRadius: 20, color: Colors.black.withOpacity(0.1), offset: Offset(0, 10))],
          shape: BoxShape.circle,
           ),
         ),
            Positioned(
                bottom: 0,
                right: 10,
                child: Container(
                  height: 60,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 2,
                      color: Colors.amberAccent,
                    ),
                    color: Colors.black,
                  ),
                  child: IconButton(
                    iconSize: 25,
                    onPressed: (){ //on press
                      _getFromGallery();
                    },
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    icon: const Icon(
                      Icons.add_a_photo_outlined,
                      color: Colors.amberAccent,
                    )
                  ),

                )),
        ]
       )
      )
     ),

          Center(
            child: Text(
              userName,
              style: const TextStyle(height: 2,
                  color: Colors.amberAccent, fontSize: 37, fontWeight: FontWeight.w700),
            ),
          ),
          Center(
            //padding: const EdgeInsets.only(top: 50, left: 20,),
            child: Text(
              '\n ' + major,
              style: const TextStyle(color: Colors.amberAccent, fontSize: 32),
            ),
          ),
          Center(
            //padding: const EdgeInsets.only(top: 0, left: 20,),
            child: Text(
              '\n ' + standing,
              style: const TextStyle(color: Colors.amberAccent, fontSize: 32),
            ),
          ),
          Center(
          heightFactor: 2.9,
          child:
          RaisedButton(
            child: const Text("Modify my items",
              style: TextStyle(fontSize: 25, letterSpacing: 2, color: Colors.black,
                  fontWeight: FontWeight.w700  ),),
            onPressed: () {
              Navigator.pushNamed(context, 'modifylist');
            },
            color: Colors.amberAccent,
            padding: const EdgeInsets.symmetric(horizontal: 29, vertical: 10),
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            )
          ),          
          /*
          Container( //cont
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child:  Card(
              margin: const EdgeInsets.fromLTRB(20, 6, 20, 0),
              child: ListTile(
                leading: const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.brown,
                ),
                title: Text(userName),
                subtitle: Text(userEmail),
              )
            )
          ),
*/
    /*
          const SizedBox(height: 20.0, width: 50), ElevatedButton( child: const Text(' empty ',),
              onPressed: () {
                //Navigator.pushNamed(context, 'profile');
              }
          ),
          */
        ],
    ),
      ])

        ),
    );
  }
}
