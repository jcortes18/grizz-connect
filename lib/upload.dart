import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:grizz_connect/main.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:grizz_connect/firebase_api.dart';
import 'package:intl/intl.dart';

import 'package:grizz_connect/marketplace_main.dart';


class UploadItem extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}
class _UploadPageState extends State<UploadItem>{
  FirebaseFirestore fs = FirebaseFirestore.instance;

  final TextEditingController _itemNameController = new TextEditingController();
  final TextEditingController _priceController = new TextEditingController();
  final TextEditingController _descriptionController = new TextEditingController();
  final TextEditingController _categoryController = new TextEditingController();
  final TextEditingController _imageURLController = new TextEditingController();
  final TextEditingController _imageName = new TextEditingController();

  bool _addedItem = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _itemNameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    // _imageURLController.dispose();
    // _imageName.dispose();
    super.dispose();
  }

  String dropdownValue = '', error = '';
  int count = 0;

  UploadTask? task;
  File? file;
  String imageName = "";

  bool viewURL = false;

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final user = _auth.currentUser;
    final userid = user!.uid.toString();

    CollectionReference items = FirebaseFirestore.instance.collection('Items');

    Future selectFile() async {
      final result = await FilePicker.platform.pickFiles(allowMultiple: false);
      if (result == null) return;

      final path = result.files.single.path!;
      imageName =  result.files.single.name;

      setState(() => file = File(path));
      print("file is ..");
      print(file);
      return imageName.toString();
    }

    // Future uploadFile() async {
    //   if (file == null) return;
    //
    //   final fileName = basename(file!.path);
    //   print(fileName);
    //   final destination = 'items/$fileName';
    //   print(destination);
    //
    //   task = FirebaseApi.uploadFile(destination, file!);
    //   setState(() {});
    //
    //   if (task == null) return;
    //
    //   final snapshot = await task!.whenComplete(() {});
    //   final url = await snapshot.ref.getDownloadURL();
    //   setState(() {
    //     _imageURLController.text = url.toString();
    //   });
    //   print('Download-Link:');
    //   print(_imageURLController.text);
    // }

    Future<void> addItems() async {

      if (file == null) return;

      final fileName = basename(file!.path);
      final destination = 'items/$fileName';

      task = FirebaseApi.uploadFile(destination, file!);
      setState(() {});

      if (task == null) return;
      final snapshot = await task!.whenComplete(() {});
      final url = await snapshot.ref.getDownloadURL();

      _imageURLController.text = url.toString();
      print('Download-Link:');
      print(_imageURLController.text);

      return items.add({
        'ItemName': toBeginningOfSentenceCase(_itemNameController.text),
        'Description': toBeginningOfSentenceCase(_descriptionController.text),
        'Price': _priceController.text,
        'Category': _categoryController.text,
        'imageURL': _imageURLController.text,
        'User': userid,
      })
      // .then((value) => print(value))
      // .catchError((error) => print("Failed to add: $error"));

          .then((value) => setState(() {
        _addedItem = true;
        print("Item Added");
      }))
          .catchError((error) => print("Failed to add: $error"));
    }

    final fileName = file != null ? basename(file!.path) : 'No File Selected';

    return Scaffold(
      appBar: AppBar(
        title: const Text("Item Insertion"),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 25, left: 20),
            child: const Text('Enter an item to sell!',
              style: TextStyle(color: Colors.black, fontSize: 28,
                  fontWeight: FontWeight.w700),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
            child:
            Column(
              children: [
                // item name
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: TextFormField(
                    controller: _itemNameController,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
                    // onChanged: (value){
                    //   setState(() {
                    //     itemName = value.t;
                    //   });
                    // },
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber),
                      ),
                      border: OutlineInputBorder(),
                      //labelStyle: TextStyle(color: Colors.grey),
                      labelText: 'Item Name',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: TextFormField(
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    //  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                    inputFormatters: [
                      FilteringTextInputFormatter(RegExp("[0-9.]"), allow: true),],
                    // onChanged: (value){
                    //   setState(() {
                    //      //price = value as double;
                    //      //_priceController.text = value;
                    //   });
                    // },
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber),
                      ),
                      border: OutlineInputBorder(),
                      labelText: 'Price (Must be in Numbers)',
                    ),
                  ),
                ),
                // description
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: TextFormField(
                    controller: _descriptionController,
                    // onChanged: (value){
                    //   setState(() {
                    //     description = value;
                    //   });
                    // },
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber),
                      ),
                      border: OutlineInputBorder(),
                      labelText: 'Short Description',
                    ),
                  ),
                ),
                // category
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Choose a category: ', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700),),
                      DropdownButton<String>(
                        isExpanded: true,
                        value: dropdownValue,
                        icon: const Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: const TextStyle(color: Colors.black),
                        underline: Container(
                          height: 2,
                          color: Colors.amber,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
                        items: <String>['Books', 'Electronics', 'Furniture', 'Lab Kits', 'Supplies', '']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                // picture
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('Choose a picture: ', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700),),
                      OutlinedButton(
                          child: const Text('Add'),
                          style: OutlinedButton.styleFrom(
                            primary: Colors.black,
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                            side: const BorderSide(color: Colors.amber),
                          ),
                          onPressed: () async {
                            var name = await selectFile();
                            print("image name is ..");
                            print(name);
                            _imageName.text = name;

                          }),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(''+_imageName.text+'',
                        style: const TextStyle(
                            color: Colors.black, fontSize: 15.0,
                            fontWeight: FontWeight.w700)),
                  ],
                ),
                // Enter Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Center(
                    child: ElevatedButton(
                      child: const Text('Enter'),
                      style: ElevatedButton.styleFrom(
                        onPrimary: Colors.black,
                        primary: Colors.amber,
                        elevation: 8,
                        textStyle: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      onPressed: () async {
                        if (_itemNameController.text.isEmpty || _descriptionController.text.isEmpty || _priceController.text.isEmpty || dropdownValue.isEmpty || _imageName.text.isEmpty) {
                          setState(() => error = ' All fields required ');
                        }
                        else{
                          _categoryController.text = dropdownValue;
                          await addItems(); // actually adds items to firestoreDB
                          if(_addedItem == true){
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Item Added!'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.of(context).popUntil((_) => count++ >= 2),
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          }
                          else{
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Could not add item. Try again!'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.of(context),
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          };
                        }
                      },
                    ),
                  ),
                ),
                // Error text
                Text(''+error+'',
                    style: const TextStyle(
                        color: Colors.red, fontSize: 25.0, backgroundColor: Colors.white,
                        fontWeight: FontWeight.w700)
                )
              ],
            ),
          ),
        ],
      ),
    );


  }




}