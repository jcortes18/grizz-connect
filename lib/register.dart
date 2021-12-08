import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grizz_connect/database.dart';
import 'package:image_picker/image_picker.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  _MyRegisterState createState() => _MyRegisterState();

}

class _MyRegisterState extends State<MyRegister> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String displayName = '';
  String email = '';
  String pass = '';
  String error = '';
  String standing = '';
  String major = '';
  File? file;
  String url = '';
  void _getFromGallery() async{
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 150,
      maxWidth: 150,
    );
    setState(() {
      file = File(pickedFile!.path);
      //uploadFile();
    });
  }
  /*
  uploadFile() async{
    var imageFile = FirebaseStorage.instance.ref().child("path").child("/.jpg");
    UploadTask task = imageFile.putFile(file!);
    TaskSnapshot snapshot = await task;
    url = await snapshot.ref.getDownloadURL();
    await FirebaseFirestore.instance.collection("data").doc().set({
      'displayName': displayName,
      'major': major,
      'standing': standing,
      'imageUrl':url,
      //"userId":userid
    });
    //print(url);
  }
   */

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('Register.jpg'), fit: BoxFit.fitHeight
        ),
      ),
      child: Scaffold(

        backgroundColor: const Color.fromRGBO(240,230,140, 90),
        appBar: AppBar(

          title: const Text('GrizzConnect'),
          foregroundColor: Colors.black,

          backgroundColor: Colors.amberAccent,
          elevation: 25,

          actions: <Widget>[
            TextButton.icon(
              icon: const Icon(Icons.person, color: Colors.black, size: 27,),
              label: const Text('Login',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              onPressed: () => Navigator.pushNamed(context, 'profile'),
            ),
          ],
        ),

        body: Stack(

          children: [
            Container(

              padding: const EdgeInsets.only(left: 32, top: 10),
              child: const Text(
                '\n    Registration Form',
                style: TextStyle(color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),

            SingleChildScrollView(
              child: Container(

                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(

                      margin: const EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (val) {
                              if (val!.isNotEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            onChanged: (val) {
                              //validator: (val) => val.length > 5 ? 'Enter an email': 'null';
                              setState(() => displayName = val);
                            },
                            style: const TextStyle(color: Colors.black54,),
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                fillColor: Colors.amberAccent,
                                filled: true,
                                hintText: "Name",
                                hintStyle: const TextStyle(color: Colors.black26),

                                border: OutlineInputBorder(

                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          const SizedBox(

                            height: 30,
                          ),
                          TextFormField(
                            validator: (val) {
                              if (val!.isNotEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            onChanged: (val) {
                              //validator: (val) => val.length > 5 ? 'Enter an email': 'null';
                              setState(() => major = val);
                            },
                            style: const TextStyle(color: Colors.black54,),
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                fillColor: Colors.amberAccent,
                                filled: true,
                                hintText: "major",
                                hintStyle: const TextStyle(color: Colors.black26),

                                border: OutlineInputBorder(

                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          const SizedBox(

                            height: 30,
                          ),
                          TextFormField(
                            validator: (val) {
                              if (val!.isNotEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            onChanged: (val) {
                              //validator: (val) => val.length > 5 ? 'Enter an email': 'null';
                              setState(() => standing = val);
                            },
                            style: const TextStyle(color: Colors.black54,),
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                fillColor: Colors.amberAccent,
                                filled: true,
                                hintText: "Standing",
                                hintStyle: const TextStyle(color: Colors.black26),

                                border: OutlineInputBorder(

                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          const SizedBox(

                            height: 30,
                          ),
                          TextFormField(
                            onChanged: (val) {
                              setState(() => email = val);
                            },
                            style: const TextStyle(color: Colors.black54),
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                fillColor: Colors.amberAccent,
                                filled: true,
                                hintText: "Email",
                                hintStyle: const TextStyle(color: Colors.black26),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            onChanged: (val) {
                              setState(() => pass = val);
                            },
                            style: const TextStyle(color: Colors.black54),
                            obscureText: true,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                fillColor: Colors.amberAccent,
                                filled: true,
                                hintText: "Password",
                                hintStyle: const TextStyle(color: Colors.black26),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          const SizedBox(
                            height: 29,   //height of signup and button
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container( //cont
                                child: IconButton(
                                    iconSize: 0,
                                    onPressed: (){ //on press
                                      _getFromGallery();
                                    },
                                    padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                    icon: const Icon(
                                      Icons.add_a_photo,
                                      size: 42,
                                      color: Colors.redAccent,
                                    )
                                ),

                              ),
                              const Text(
                                ' Sign Up ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 27,
                                    fontWeight: FontWeight.w700),
                              ),

                              CircleAvatar(
                                radius: 30,
                                backgroundColor: const Color(0xff4c505b),
                                child: IconButton(
                                    iconSize: 42,
                                    color: const Color.fromRGBO(254, 215, 102, 2),
                                    onPressed: () async {
                                      setState(() => error = '');
                                      if(file!=null ) {
                                        var imageFile = FirebaseStorage.instance
                                            .ref().child(displayName).child("/.jpg");
                                        UploadTask task = imageFile.putFile(
                                            file!);
                                        TaskSnapshot snapshot = await task;
                                        url =
                                        await snapshot.ref.getDownloadURL();
                                      }
                                      if(displayName.isEmpty || email.isEmpty || pass.isEmpty || standing.isEmpty || major.isEmpty) {
                                        setState(() => error = ' All fields required ');
                                      }

                                      else if(!email.endsWith('@oakland.edu') || email.length < 15) {
                                        setState(() => error = 'Oakland University Email required ');
                                      }
                                      else
                                      { //start if
                                        try { //try input
                                          UserCredential result = await _auth.createUserWithEmailAndPassword(
                                              email: email, password: pass);
                                          User? user = result.user;
                                          await DatabaseService(
                                              uid: user!.uid).updateUserData(
                                              displayName, major, standing,
                                              url);
                                          Navigator.pushNamed(context, 'start');
                                        } on FirebaseAuthException catch (e) {
                                          if (e.code == 'weak-password') {
                                            setState(() =>
                                            error = 'weak password entered');
                                          } else if (e.code ==
                                              'email-already-in-use') {
                                            setState(() =>
                                            error = 'Email already in use');
                                          }
                                        } catch (e) {
                                          print(e);
                                        }
                                      }

                                    },
                                    icon: const Icon(
                                      Icons.arrow_forward,

                                    )

                                ),

                              ),

                            ],
                          ),





                          const SizedBox(height: 10.0),
                          Text(error,
                              style: const TextStyle(color: Colors.red, fontSize: 20.0,
                                fontWeight: FontWeight.w700,
                              )
                          )
                        ],

                      ),

                    )

                  ],

                ),

              ),

            ),

          ],
        ),
      ),
    );
  }
}
