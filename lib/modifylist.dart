import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grizz_connect/item.dart';
import 'package:grizz_connect/upload.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:flutter/material.dart';

class ModifyListTab extends StatefulWidget {
  const ModifyListTab({Key? key}) : super(key: key);

  @override
  _ModifyListState createState() => _ModifyListState();
}

class _ModifyListState extends State<ModifyListTab> {
  int selectedPage = 0;
  // final Stream<QuerySnapshot> items = FirebaseFirestore.instance.collection("Items").where
  // ("Category", isEqualTo: _filterButtonSelection).snapshots();
  late Stream<QuerySnapshot> items;

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final user = _auth.currentUser;
    final userid = user!.uid.toString();
    items = FirebaseFirestore.instance.collection("Items").where("User", isEqualTo: userid).snapshots();

    return Scaffold(
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

        ],
      ),
      body: Stack(fit: StackFit.expand, children: [
        //buildFloatingSearchBar(),
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.only(top: 50, right:20, left: 20, bottom: 20),
          child: //<Widget>[
          Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                // Major Category text row
                Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      SizedBox(
                        child: Text('Manage my items',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 25,
                            )),
                      )
                    ]),
                //Clear Filter button
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 20, left: 50, right: 50,),

                        child: OutlinedButton(
                          child: const Text('Refresh list',
                            style: TextStyle(color: Colors.black,
                              fontSize: 25,
                            ),),
                          style: OutlinedButton.styleFrom(
                            primary: Colors.black,
                            backgroundColor: Colors.amberAccent,
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                            side: const BorderSide(color: Colors.black,),
                          ),
                          onPressed: () {
                            setState(() {
                              items = FirebaseFirestore.instance.collection("Items").where("User", isEqualTo: userid).snapshots();

                              //items = FirebaseFirestore.instance.collection("Items").snapshots();
                            });
                          },
                        ),
                      ),
                    ]
                ),

                // Item cards column
                Flexible(
                  child: StreamBuilder<QuerySnapshot> (
                    stream: items,
                    builder: (
                        BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot,
                        ){
                      if(snapshot.hasError){
                        return const Text("Something went wrong");
                      }
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return const Text("Loading...");
                      }

                      final data = snapshot.requireData;
                      if(data.docs.isEmpty){
                        return const Text("        you have no items for sale"
                                          +"\n"
                                         +"upload more items to display here!"
                        );
                      }
                      return MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        removeRight: true,
                        child: ListView.builder(
                          itemBuilder: (context, index){
                            return Card(
                              elevation: 100.0,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                    title: Text(data.docs[index]['ItemName'],
                                        style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                                    subtitle: Text(data.docs[index]['Price'].toString(),
                                        style: const TextStyle(fontSize: 20,)),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,// spaceAround,// end,
                                    children: <Widget>[
                                      TextButton(
                                        child: const Text('Delete', style: TextStyle(height: 0, fontSize: 25, ),),
                                        onPressed: () {
                                          setState(() {
                                            var id = (data.docs[index].id);
                                            //items.contains(data.docs[]);
                                            //var remove = data.docs.removeAt(index);

                                            final collection = FirebaseFirestore.instance.collection('Items');
                                            collection
                                                .doc(id) // <-- Doc ID to be deleted.
                                                .delete() // <-- Delete
                                                .then((_) => print('Deleted'))
                                                .catchError((error) => print('Delete failed: $error'));
                                              //print(id);
                                          });
                                        },
                                      ),
                                      //const SizedBox(height: 20),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                          shrinkWrap: true,
                          itemCount: data.size,
                        ),
                      );
                    },
                  ),
                ),

              ] // Column Children
          ),
          //]
        ),
        //buildFloatingSearchBar(),
      ]),

      floatingActionButton: SizedBox(
        width: 50.0,
        height: 50.0,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, 'welcome');
            //Navigator.push(
            //    context, MaterialPageRoute(builder: (context) => UploadItem()));
          },
          child: const Icon(Icons.house_rounded, color: Colors.black,size: 45,),
          backgroundColor: Colors.amber,
          elevation: 10.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29)),

        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

    );

  }
//search bar with profile button

}





