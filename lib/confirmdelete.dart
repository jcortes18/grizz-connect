import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'database.dart';


class deleteItemPage extends StatefulWidget {
  final DocumentSnapshot item;

  deleteItemPage({required this.item});

  @override
  _deleteItemPageState createState() => _deleteItemPageState();}

class _deleteItemPageState extends State<deleteItemPage> {
  final myController = TextEditingController();
  String comment = '';

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        backgroundColor: const Color.fromRGBO(158, 158, 158, 1.0),
        //appBar: _appBar(context, AppBar().preferredSize.height),
        appBar: AppBar(
            backgroundColor: const Color.fromRGBO(47, 46, 46, 1.0),
            centerTitle: true,
            title: const Text(
              'Grizz Connect',
            )),
        body: SingleChildScrollView(
          //padding: const EdgeInsets.all(8.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  //carousel(context),
                  Image.network(widget.item['imageURL']),
                  Card(color: const Color.fromRGBO(201, 199, 199, 1.0),
                      child: ListTile(title: Text(
                          "Item Name: " + widget.item['ItemName'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold)),)),
                  Card(color: const Color.fromRGBO(201, 199, 199, 1.0),
                      child: ListTile(title: Text(
                          "Price: " + widget.item['Price'].toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(

                              fontWeight: FontWeight.bold)),)),
                  Card(color: const Color.fromRGBO(201, 199, 199, 1.0),
                      child: ListTile(title: Text(
                          "Details: " + widget.item['Description'].toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold)),)),

                ])
        )
    );
  }
}
