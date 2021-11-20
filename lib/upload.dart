import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:grizz_connect/main.dart';


class UploadItem extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}
class _UploadPageState extends State<UploadItem>{
  FirebaseFirestore fs = FirebaseFirestore.instance;

  final TextEditingController _itemNameController = new TextEditingController();
  final TextEditingController _priceController = new TextEditingController();
  final TextEditingController _descriptionController = new TextEditingController();

  String itemName = '', description = '', dropdownValue = '', error = '';
  double price = 0;


  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final user = _auth.currentUser;
    final userid = user!.uid.toString();

    CollectionReference items = FirebaseFirestore.instance.collection('Items');

    Future<void> addItems() async {

      return items.add({
        'ItemName': itemName,
        'Description': description,
        'Price': price})
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
                      onChanged: (value){
                        setState(() {
                          itemName = value;
                        });
                      },
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return null;
                        }
                        return 'Please make inputs';
                      },
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
                      onChanged: (value){
                        setState(() {
                          price = value as double;
                        });
                      },
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
                      onChanged: (value){
                        setState(() {
                          description = value;
                        });
                      },
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

                          if (itemName.isEmpty || description.isEmpty || price.isNaN || dropdownValue.isEmpty) {
                            setState(() => error = ' All fields required ');

                            // builder: (BuildContext context) => AlertDialog(
                            //   title: const Text('Error'),
                            //   content: const Text('All fields required!'),
                            //   actions: <Widget>[
                            //     TextButton(
                            //       onPressed: () => Navigator.pop(context, 'OK'),
                            //       child: const Text('OK'),
                            //     ),
                            //   ],
                            // );
                          }
                          else{
                            addItems();
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


