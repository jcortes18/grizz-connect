import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'database.dart';


class ItemPage extends StatefulWidget {
  final DocumentSnapshot item;

  ItemPage({required this.item});

  @override
  _ItemPageState createState() => _ItemPageState();}

class _ItemPageState extends State<ItemPage> {
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
                  TextFormField(validator: (val) {

                    if (val!.isNotEmpty) {
                      return 'Please enter some text';}
                    return null;},
                    onChanged: (val) {
                      //validator: (val) => val.length > 5 ? 'Enter an email': 'null';
                      setState(() => comment = val);
                    },
                    controller: myController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding:
                        EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                        hintText: "Add Comment",
                        suffixIcon: IconButton(
                          onPressed: myController.clear,
                          icon: Icon(Icons.clear),)),
                  ),
                  FloatingActionButton.extended(
                    onPressed: () async { //showDialog(context: context, builder: (context) {
                      //return AlertDialog(content: Text(myController.text),);
                      final FirebaseAuth _auth = FirebaseAuth.instance;
                      final user = _auth.currentUser;
                      final userid = user!.uid.toString();

                      await DatabaseService(uid: widget.item.id).updateComments(
                          comment, user!.displayName.toString(), user!.email.toString()); myController.clear();
                    },
                    label: const Text('Add Comment'),
                    icon: const Icon(Icons.add_comment),
                    //.thumb_up),
                    backgroundColor: Colors.amber,
                    tooltip: 'Add Comment',
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance.collection('comments')
                            .doc(widget.item.id)
                            .collection('comments').snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator(),);
                          } else {
                            return ListView(
                              shrinkWrap: true,
                              children: snapshot.data!.docs.map((doc) {
                                return Card(child: ListTile(
                                  //title: Text(user!.email.toString()),
                                  title: Text(doc['name'] + "\t-\t" + "(" + doc['email'] + ")"),
                                  subtitle: Text(doc['comment']),),);
                              }).toList(),
                            );
                          }
                        }
                    ),
                  ),
                ])
        )
    );
  }
}



// **CODE FOR CUSTOM APP BAR** //

/*_appBar(context, height) => PreferredSize(
  preferredSize: Size(MediaQuery.of(context).size.width, height+60),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      FloatingActionButton(elevation: 0, child:Image.asset("assets/back_button.png", width: 27, height: 30,),
          onPressed: (){},
          backgroundColor: Colors.transparent
      ),
      const Center(child: Text("GrizzConnet", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color.fromRGBO(255, 193, 8, 1.0)),),
      ),
      FloatingActionButton(elevation: 0, child:Image.asset("assets/bag_button.png", width: 40, height: 40,),
          onPressed: (){},
          backgroundColor: Colors.transparent
      ),
    ],
  ),
);
// **CODE FOR PICTURES FOR CAROUSEL** //
final List<String> imgList = [
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];
// **CODE FOR CAROUSEL** //
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