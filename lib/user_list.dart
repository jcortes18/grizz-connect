import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grizz_connect/database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class profileInfo extends StatefulWidget {
  const profileInfo({Key? key}) : super(key: key);
  @override
  _profileInfoState createState() => _profileInfoState();
}

class _profileInfoState extends State<profileInfo> {
  String id='';
  double dimention = 200;
  File? file;
  String url = '';
  String urrl = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;
    final userid = user!.uid.toString();

    //final userEmail = user.email.toString();
    var userName = '';
    var major = '';
    var standing = '';
    var urrl = '';
    /*uploadFile() async{
      var imageFile = FirebaseStorage.instance.ref().child("path").child("/.jpg");
      UploadTask task = imageFile.putFile(file!);
      TaskSnapshot snapshot = await task;
      url = await snapshot.ref.getDownloadURL();
      //await DatabaseService(uid: user!.uid).updateUserData(url);

      await FirebaseFirestore.instance.collection("data").doc().set({
        "imageUrl":url,
      });
      print(url);
    }*/
    void _getFromGallery() async{
      XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxHeight: 150,
        maxWidth: 150,
      );
      setState(() async {
        file = File(pickedFile!.path);
        //uploadFile();
        var imageFile = FirebaseStorage.instance.ref().child(userName).child("/.jpg");
        UploadTask task = imageFile.putFile(file!);
        TaskSnapshot snapshot = await task;
        url = await snapshot.ref.getDownloadURL();
        await DatabaseService(uid: userid).updateUserData(userName, major, standing, url);
        //or user user.uid for userid
        //print(userid);
      });
    }
    //id = user.uid;
    final userdata = Provider.of<QuerySnapshot>(context);
    List<String> records = [];
    for (var doc in userdata.docs) {
      if(doc.id == userid)
      {
        records = [doc.get('displayName'),
                   doc.get('major'),
                   doc.get('standing'),
                   doc.get('imageUrl'),
    ];
        user.updateDisplayName(doc.get('displayName'));
        userName = records[0];
        major = records[1];
        standing = records[2];
        urrl = records[3];
        //print(doc.data()); //get all data as a set
      }
    }
    //print(urrl.toString());

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

                    onPressed: (){
                      Navigator.pushNamed(context, 'login');}
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
                        child: (urrl!="")?Image.network(urrl,fit: BoxFit.fill)//(file!=null)?Image.file(File(file!.path),fit: BoxFit.fill)
                            :
                        Container(child:
                          Icon(Icons.person_rounded, color: Colors.white, size: MediaQuery.of(context).size.width * .4,),
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