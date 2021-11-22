import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:grizz_connect/main.dart';
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

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _itemNameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  String dropdownValue = '', error = '';
  int count = 0;

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final user = _auth.currentUser;
    final userid = user!.uid.toString();

    CollectionReference items = FirebaseFirestore.instance.collection('Items');

    Future<void> addItems() async {

      return items.add({
        'ItemName': _itemNameController.text,
        'Description': _descriptionController.text,
        'Price': _priceController.text,
        'Category': _categoryController.text,
        'User': userid})
          .then((value) => print("Item Added"))
          .catchError((error) => print("Failed to add: $error"));

    }

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
            padding: const EdgeInsets.only(top: 25, left: 30),
            child: const Text('Enter an item to sell!',
            style: TextStyle(color: Colors.black, fontSize: 28,
                fontWeight: FontWeight.w700),
           ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 60),
            child:
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    child: TextFormField(
                      controller: _itemNameController,
                      // onChanged: (value){
                      //   setState(() {
                      //     itemName = value;
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
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    child: TextFormField(
                      controller: _priceController,
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
                        labelText: 'Price',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          //padding: const EdgeInsets.only(top: 80, left: 30),
                          child: const Text('Choose a category: ',
                            style: TextStyle(color: Colors.black, fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
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
                          items: <String>['Books', 'Electronic', 'Furniture', 'Lab Kits', 'Supplies', '']
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
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Choose a picture: ',
                        style: TextStyle(color: Colors.black, fontSize: 18,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    child: Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.amber,
                          elevation: 8,
                          textStyle: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        onPressed: () {

                          if (_itemNameController.text.isEmpty || _descriptionController.text.isEmpty || _priceController.text.isEmpty || dropdownValue.isEmpty) {
                            setState(() => error = ' All fields required ');

                          }
                          else{
                            _categoryController.text = dropdownValue;
                            addItems();
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
                        },
                        child: const Text('Enter'),
                      ),
                    ),
                  ),
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


