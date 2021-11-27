import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:grizz_connect/upload.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:flutter/material.dart';

import 'item.dart';

class MarketplaceTab extends StatefulWidget {
  const MarketplaceTab({Key? key}) : super(key: key);

  @override
  _MarketplaceState createState() => _MarketplaceState();
}

class _MarketplaceState extends State<MarketplaceTab> {
  int selectedPage = 0;
  // ** pages options for bottom navigation bar **
  // _onTap() {
  //   Navigator.of(context).push(MaterialPageRoute(
  //       builder: (BuildContext context) => _pageOptions[selectedPage]));
  // }
  // final _pageOptions = [
  //   //otherPage(), // right button
  //   //otherPage(), // middle button
  //   //otherPage(), // left button
  // ];


  // final Stream<QuerySnapshot> items = FirebaseFirestore.instance.collection("Items").where("Category", isEqualTo: _filterButtonSelection).snapshots();
  late Stream<QuerySnapshot> items;

  @override
  void initState() {
    super.initState();
    // getSnapshot();
    items = FirebaseFirestore.instance.collection("Items").snapshots();
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final user = _auth.currentUser;
    final userid = user!.uid.toString();


    return Scaffold(
      body: Stack(fit: StackFit.expand, children: [
        //buildFloatingSearchBar(),
        SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.only(top: 140, right:20, left: 20),
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
                        child: Text('Major Categories',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Roboto',
                              fontSize: 25,
                            )),
                      )
                    ]),

                // Filter button horizontal row
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Column(children: [
                        TextButton(
                            onPressed: () {
                              setState(() {
                                items = FirebaseFirestore.instance.collection("Items").where("Category", isEqualTo: "Books").snapshots();
                              });
                            },
                            child: const Icon(
                              Icons.book,
                              color: Colors.amber,
                              size: 100,
                            )),
                        const Text('Books')
                      ]),
                      Column(children: [
                        TextButton(
                            onPressed: () {
                              setState(() {
                                items = FirebaseFirestore.instance.collection("Items").where("Category", isEqualTo: "Furniture").snapshots();
                              });
                            },
                            child: const Icon(
                              Icons.chair,
                              color: Colors.amber,
                              size: 100,
                            )),
                        const Text('Furniture')
                      ]),
                      Column(children: [
                        TextButton(
                            onPressed: () {
                              setState(() {
                                items = FirebaseFirestore.instance.collection("Items").where("Category", isEqualTo: "Electronics").snapshots();
                              });
                            },
                            child: const Icon(
                              Icons.computer,
                              color: Colors.amber,
                              size: 100,
                            )),
                        const Text('Electronics')
                      ]),
                      Column(children: [
                        TextButton(
                            onPressed: () {
                              setState(() {
                                items = FirebaseFirestore.instance.collection("Items").where("Category", isEqualTo: "Lab Kits").snapshots();
                              });
                            },
                            child: const Icon(
                              Icons.science_sharp,
                              color: Colors.amber,
                              size: 100,
                            )),
                        const Text('Lab Kits')
                      ]),
                      Column(children: [
                        TextButton(
                            onPressed: () {
                              setState(() {
                                items = FirebaseFirestore.instance.collection("Items").where("Category", isEqualTo: "Supplies").snapshots();
                              });
                            },
                            child: const Icon(
                              Icons.backpack,
                              color: Colors.amber,
                              size: 100,
                            )),
                        const Text('Supplies')
                      ]),
                      Column(children: [
                        TextButton(
                            onPressed: () {},
                            child: const Icon(
                              Icons.favorite,
                              color: Colors.amber,
                              size: 100,
                            )),
                        const Text('Favorites')
                      ]),
                    ],
                  ),
                ),

                //Clear Filter button
                Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, left: 3.5),
                        child: OutlinedButton(
                          child: const Text('Clear selection'),
                          style: OutlinedButton.styleFrom(
                            primary: Colors.black,
                            //backgroundColor: Colors.amber,
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                            side: const BorderSide(color: Colors.amber),
                          ),
                          onPressed: () {
                            setState(() {
                              items = FirebaseFirestore.instance.collection("Items").snapshots();
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
                            return Text("Something went wrong");
                          }
                          if(snapshot.connectionState == ConnectionState.waiting){
                            return Text("Loading...");
                          }

                          final data = snapshot.requireData;

                          return MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: ListView.builder(
                                //scrollDirection: Axis.vertical,
                                //physics: ScrollPhysics(),
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index){
                                  return Card(
                                    elevation: 4.0,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        ListTile(
                                          title: Text(data.docs[index]['ItemName']),
                                          subtitle: Text(data.docs[index]['Price'].toString()),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            TextButton(
                                              child: const Text('BUY'),
                                              onPressed: () {
                                                Navigator.push(
                                                    context, MaterialPageRoute(builder: (context) => ItemPage(item: data.docs[index])));
                                                },
                                            ),
                                            const SizedBox(width: 8),
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
        buildFloatingSearchBar(),
      ]),

      // Floating '+' button
      floatingActionButton: SizedBox(
        width: 75.0,
        height: 75.0,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => UploadItem()));
          },
          child: const Icon(Icons.add, color: Colors.black,),
          backgroundColor: Colors.amber,
          elevation: 10.0,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      // Bottom Navigation Bar
      //extendBody: true, //show body behind nav bar
      // bottomNavigationBar: Padding(
      //     padding: const EdgeInsets.only(top: 0, bottom: 10),
      //     child: DotNavigationBar(
      //       backgroundColor: Colors.black,
      //       dotIndicatorColor: Colors.white,
      //       unselectedItemColor: Colors.grey[300],
      //       selectedItemColor: Colors.amber,
      //       items: [
      //         DotNavigationBarItem(
      //           icon: const Icon(Icons.sell),
      //         ),
      //         DotNavigationBarItem(
      //           icon: const Icon(Icons.health_and_safety),
      //         ),
      //         DotNavigationBarItem(
      //           icon: const Icon(Icons.settings),
      //         ),
      //       ],
      //       currentIndex: selectedPage,
      //       onTap: (index) {
      //         setState(() {
      //           selectedPage = index;
      //         });
      //         _onTap();
      //       },
      //     )),
    );
  }

  // Widget buildItemList(String selection){
  //   final Stream<QuerySnapshot> allItems = FirebaseFirestore.instance.collection("Items").where("Category", isEqualTo: selection).snapshots();
  //
  //   // if searchbar selection is not empty, then stream == search bar text
  //   // if filter button is selected, then stream == filter button ToString()
  //   // if no filter button selected and searchbar is empty, then stream == all items in Item collection
  //   final String selection;
  //
  //   return StreamBuilder<QuerySnapshot> (
  //     stream: items,
  //     builder: (
  //         BuildContext context,
  //         AsyncSnapshot<QuerySnapshot> snapshot,
  //         ){
  //       if(snapshot.hasError){
  //         return Text("Something went wrong");
  //       }
  //       if(snapshot.connectionState == ConnectionState.waiting){
  //         return Text("Loading...");
  //       }
  //
  //       final data = snapshot.requireData;
  //
  //       return ListView.builder(
  //         //scrollDirection: Axis.vertical,
  //         //physics: ScrollPhysics(),
  //         physics: NeverScrollableScrollPhysics(),
  //         shrinkWrap: true,
  //         itemCount: data.size,
  //         itemBuilder: (context, index){
  //           // return Text('Name: ${data.docs[index]['ItemName']}, Price: ${data.docs[index]['Price']}');
  //           return Card(
  //             elevation: 4.0,
  //             child: Column(
  //               children: <Widget>[
  //                 ListTile(
  //                   title: Text(data.docs[index]['ItemName']),
  //                   subtitle: Text(data.docs[index]['Price'].toString()),
  //                 ),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.end,
  //                   children: <Widget>[
  //                     TextButton(
  //                       child: const Text('BUY'),
  //                       onPressed: () {/* ... */},
  //                     ),
  //                     const SizedBox(width: 8),
  //
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           );
  //         }, // itemBuilder
  //       );
  //     }, // Builder
  //   );
  // }

  //search bar with profile button
  Widget buildFloatingSearchBar() {
    TextEditingController _searchQuery = new TextEditingController();

    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      hint: 'Search Item...',
      scrollPadding: const EdgeInsets.only(top: 10, bottom: 56, left: 10, right: 10),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      borderRadius: BorderRadius.circular(30),
      debounceDelay: const Duration(milliseconds: 500),
      //automaticallyImplyDrawerHamburger: true,
      closeOnBackdropTap: true,
      //automaticallyImplyBackButton: false,
      onQueryChanged: (query) {
        _searchQuery.text = query;
      },

      onSubmitted: (query) {
        // setState(() {
        //   items = FirebaseFirestore.instance.collection("Items").where('ItemName', arrayContains: _searchQuery).snapshots();
        // });
        print(_searchQuery.text);
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: SlideFadeFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          // HOME icon showed when search is closed
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.house_rounded),

            onPressed: () { /* ..Go to HOME page.. */ },
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          //clears search when search bar is closed
          showIfClosed: false,
        ),
      ],
      // List of search results shown below search bar
      builder: (context, transition) {
        return
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: Colors.accents.map((color) {
                return Container(height: 50, color: color, child: Text(_searchQuery.text),);
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}

