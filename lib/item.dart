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

  String error='';

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
                  //((widget.item['imageURL']!=null)?Image.network(widget.item['imageURL'],fit: BoxFit.fill)
                    //:
                  //Icon(Icons.person_rounded, color: Colors.white, size: MediaQuery.of(context).size.width * .4,),
                  //Image.network("https://upload.wikimedia.org/wikipedia/commons/6/6b/Picture_icon_BLACK.svg"),
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
                  const SizedBox(height: 5.0),
                  Text(''+error+'',
                      style: const TextStyle(//height: 0,
                          color: Colors.red, fontSize: 25.0, //backgroundColor: Colors.transparent,
                          fontWeight: FontWeight.w700)
                  ),
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
                      if(comment.length < 1){
                       setState(() {
                         error = 'short comment';
                       });
                      }

                      else {
                        setState(() {
                          error = '';
                        });
                        await DatabaseService(uid: widget.item.id)
                            .updateComments(
                            comment, user.displayName.toString(),
                            user.email.toString());
                        myController.clear();
                      }
                      setState(() {
                        comment = '';
                      });
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
/*
Navigator.push(
context, MaterialPageRoute(builder: (context) => ItemPage(item: data.docs[index])));

*/

/*
child: CircularButton(
icon: const Icon(Icons.house_rounded, size: 32,
),
onPressed: () {
Navigator.pushNamed(context, 'welcome');
},
),*/
