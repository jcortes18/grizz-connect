import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/src/widgets/framework.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'database.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemPage extends StatefulWidget {
  final DocumentSnapshot item;

  ItemPage({required this.item});

  @override
  _ItemPageState createState() => _ItemPageState();}

class _ItemPageState extends State<ItemPage> {
  final myController = TextEditingController();
  String comment = '';
  String error = '';

  bool _showBackToTopButton = false;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        if (_scrollController.offset >= 400) {
          _showBackToTopButton = true; // show the back-to-top button
        } else {
          _showBackToTopButton = false; // hide the back-to-top button
        }
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: Duration(milliseconds: 400), curve: Curves.linear);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(158, 158, 158, 1.0),
      //appBar: _appBar(context, AppBar().preferredSize.height),
      appBar: AppBar(
          backgroundColor: const Color.fromRGBO(47, 46, 46, 1.0),
          centerTitle: true,
          title: const Text(
            'Grizz Connect'
          )),
      body: SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.vertical,
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

                Row(
                    children: <Widget> [
                      Expanded(
                        child: TextButton(
                          onPressed: () async{
                            var url = "https://venmo.com";
                            if (await launch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }}, child: Image.asset('Venmo.jpg', height: 60, width: 60),),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () async{
                            var url = "https://www.paypal.com/us/home";
                            if (await launch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }}, child: Image.asset('PayPal.png', height: 60, width: 60),),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () async{
                            var url = "https://www.zellepay.com";
                            if (await launch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }}, child: Image.asset('Zelle.png', height: 60, width: 60),),
                      ),
                      ]
                ),
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
                    if(comment == '' || comment == ' ' || comment == '  '){
                      setState(() {
                        error = 'empty comment';
                      });
                    }
                    else {
                      await DatabaseService(uid: widget.item.id).updateComments(
                          comment, user.displayName.toString(), user.email.toString());
                      myController.clear();
                      setState(() {
                        error = '';
                      });
                    }
                    setState(() { comment = ''; });
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
                            physics: ScrollPhysics(),
                            scrollDirection: Axis.vertical,
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
                const Padding(
                  padding: EdgeInsets.only(bottom: 15, right: 8.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                  ),
                ),

              ])
      ),
      floatingActionButton: _showBackToTopButton == false
          ? null
          : FloatingActionButton(
        onPressed: _scrollToTop,
        child: const Icon(Icons.arrow_circle_up),
        backgroundColor: Colors.black,
        elevation: 10.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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