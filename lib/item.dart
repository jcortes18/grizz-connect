import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';


class ItemPage extends StatefulWidget {
  final DocumentSnapshot item;

  ItemPage({required this.item});

  @override
  _ItemPageState createState() => _ItemPageState();}

class _ItemPageState extends State<ItemPage> {

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
                  Card(color: const Color.fromRGBO(201, 199, 199, 1.0), child: ListTile(title: Text("Item Name: " + widget.item['ItemName'], textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold)),)),
                  Card(color: const Color.fromRGBO(201, 199, 199, 1.0), child: ListTile(title: Text("Price: " + widget.item['Price'].toString(), textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold)),)),
                  Card(color: const Color.fromRGBO(201, 199, 199, 1.0), child: ListTile(title: Text("Details: " + widget.item['Description'].toString(), textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold)),)),
                ]
            )
        )
    );
  }
}

/*final List<String> imgList = [
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

Widget carousel(context){
  return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: CarouselSlider(
        options: CarouselOptions(
            enlargeCenterPage: true,
            enableInfiniteScroll: true
        ),
        items: imgList.map((i) => ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Image.network(i,
                    width: 1050,
                    height: 350,
                    fit: BoxFit.cover,)
                ]
            )
        )).toList(),
      )
  );
}*/