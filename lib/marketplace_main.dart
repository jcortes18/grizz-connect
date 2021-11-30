import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:grizz_connect/upload.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:flutter/material.dart';

class MarketplaceTab extends StatefulWidget {
  const MarketplaceTab({Key? key}) : super(key: key);

  @override
  _MarketplaceState createState() => _MarketplaceState();
}

class _MarketplaceState extends State<MarketplaceTab> {
  TextEditingController _searchController = TextEditingController();
  TextEditingController _filterController = TextEditingController();

  late Future resultsLoaded;
  List _allResults = [];
  List _resultsList = [];
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
  //late Stream<QuerySnapshot> items;


  @override
  void initState() {
    super.initState();
    //items = FirebaseFirestore.instance.collection("Items").snapshots();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    resultsLoaded = getItemsStreamSnapshots();
  }

  _onSearchChanged() {
    searchResultsList();
  }

  searchResultsList() {
    var showResults = [];

    if(_searchController.text != "") {
      for(var itemSnapshot in _allResults){
        var title = itemSnapshot.get('ItemName').toLowerCase();

        if(title.contains(_searchController.text.toLowerCase())) {
          showResults.add(itemSnapshot);
        }
      }
    }
    else {
      showResults = List.from(_allResults);
    }
    setState(() {
      _resultsList = showResults;
    });
  }

  filterResultsList() {
    var showResults = [];

    if(_filterController.text != "") {
      for(var itemSnapshot in _allResults){
        var category = itemSnapshot.get('Category').toLowerCase();

        if(category.contains(_filterController.text.toLowerCase())) {
          showResults.add(itemSnapshot);
        }
      }
    }
    else {
      showResults = List.from(_allResults);
    }
    setState(() {
      _resultsList = showResults;
    });
  }

  getItemsStreamSnapshots() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final user = _auth.currentUser;
    final userid = user!.uid.toString();

    var data = await FirebaseFirestore.instance
        .collection('Items')
        .get();
    setState(() {
      _allResults = data.docs;
    });
    searchResultsList();
    return "complete";
  }

  @override
  Widget build(BuildContext context) {
    // final FirebaseAuth _auth = FirebaseAuth.instance;
    // final user = _auth.currentUser;
    // final userid = user!.uid.toString();
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      extendBodyBehindAppBar: true,
      //backgroundColor: Colors.white30,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding:  const EdgeInsets.only(left:20),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black,),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.only(right:20),
          child: Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top:14),
                prefixIcon: Icon(Icons.search), hintText: 'Search...'),
            ),
          ),
        ),

      ),
      body: Stack(fit: StackFit.expand, children: [
        //buildFloatingSearchBar(),
        SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: AlwaysScrollableScrollPhysics(),
            //padding: const EdgeInsets.only(top: 140, right:20, left: 20),
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
                              // setState(() {
                              //   items = FirebaseFirestore.instance.collection("Items").where("Category", isEqualTo: "Books").snapshots();
                              // });
                              setState(() {
                                _filterController.text = 'Books';
                                filterResultsList();
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
                              // setState(() {
                              //   items = FirebaseFirestore.instance.collection("Items").where("Category", isEqualTo: "Furniture").snapshots();
                              // });
                              setState(() {
                                _filterController.text = 'Furniture';
                                filterResultsList();
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
                              // setState(() {
                              //   items = FirebaseFirestore.instance.collection("Items").where("Category", isEqualTo: "Electronics").snapshots();
                              // });
                              setState(() {
                                _filterController.text = 'Electronics';
                                filterResultsList();
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
                              // setState(() {
                              //   items = FirebaseFirestore.instance.collection("Items").where("Category", isEqualTo: "Lab Kits").snapshots();
                              // });
                              setState(() {
                                _filterController.text = 'Lab Kits';
                                filterResultsList();
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
                              // setState(() {
                              //   items = FirebaseFirestore.instance.collection("Items").where("Category", isEqualTo: "Supplies").snapshots();
                              // });
                              setState(() {
                                _filterController.text = 'Supplies';
                                filterResultsList();
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
                            onPressed: () {
                              setState(() {
                                _filterController.text = 'Favorites';
                                filterResultsList();
                              });
                            },
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
                              _searchController.clear();
                              _filterController.clear();
                              filterResultsList();
                            });
                          },
                        ),
                      ),
                    ]
                ),

                // Item cards
                Flexible(
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _resultsList.length,
                      itemBuilder: (BuildContext context, int index) =>
                          buildCard(context, _resultsList[index]),

                    ),
                  ),
                  ),
              //   Item cards column
              //   Flexible(
              //     child: StreamBuilder<QuerySnapshot> (
              //     stream: items,
              //     builder: (
              //         BuildContext context,
              //         AsyncSnapshot<QuerySnapshot> snapshot,
              //         ){
              //             if(snapshot.hasError){
              //               return Text("Something went wrong");
              //             }
              //             if(snapshot.connectionState == ConnectionState.waiting){
              //               return Text("Loading...");
              //             }
              //
              //             final data = snapshot.requireData;
              //
              //             return MediaQuery.removePadding(
              //               context: context,
              //               removeTop: true,
              //               child: ListView.builder(
              //                   physics: NeverScrollableScrollPhysics(),
              //                   itemBuilder: (context, index){
              //                     return Card(
              //                       elevation: 4.0,
              //                       child: Column(
              //                         mainAxisSize: MainAxisSize.min,
              //                         children: <Widget>[
              //                           ListTile(
              //                             title: Text(data.docs[index]['ItemName']),
              //                             subtitle: Text(data.docs[index]['Price'].toString()),
              //                           ),
              //                           Row(
              //                             mainAxisAlignment: MainAxisAlignment.end,
              //                             children: <Widget>[
              //                               TextButton(
              //                                 child: const Text('BUY'),
              //                                 onPressed: () {/* ... */},
              //                               ),
              //                               const SizedBox(width: 8),
              //                             ],
              //                           ),
              //                         ],
              //                       ),
              //                     );
              //                   },
              //                 shrinkWrap: true,
              //                 itemCount: data.size,
              //               ),
              //             );
              //          },
              //   ),
              // ),

                ] // Column Children
              ),
        //]
        ),
        //buildFloatingSearchBar(),
        // FloatingSearchBar(
        //   hint: 'Search Item...',
        //   scrollPadding: const EdgeInsets.only(top: 10, bottom: 56, left: 10, right: 10),
        //   transitionDuration: const Duration(milliseconds: 800),
        //   transitionCurve: Curves.easeInOut,
        //   physics: const BouncingScrollPhysics(),
        //   axisAlignment: isPortrait ? 0.0 : -1.0,
        //   openAxisAlignment: 0.0,
        //   width: isPortrait ? 600 : 500,
        //   borderRadius: BorderRadius.circular(30),
        //   debounceDelay: const Duration(milliseconds: 500),
        //   //automaticallyImplyDrawerHamburger: true,
        //   closeOnBackdropTap: true,
        //   //automaticallyImplyBackButton: false,
        //   // Specify a custom transition to be used for animating between opened and closed stated.
        //   transition: SlideFadeFloatingSearchBarTransition(),
        //   actions: [
        //     FloatingSearchBarAction(
        //       // HOME icon showed when search is closed
        //       showIfOpened: false,
        //       child: CircularButton(
        //         icon: const Icon(Icons.house_rounded),
        //
        //         onPressed: () { /* ..Go to HOME page.. */ },
        //       ),
        //     ),
        //     FloatingSearchBarAction.searchToClear(
        //       //clears search when search bar is closed
        //       showIfClosed: false,
        //     ),
        //   ],
        //   onQueryChanged: (query) {
        //     _searchQuery.text = query;
        //   },
        //   // clicking search button
        //   onSubmitted: (query) {
        //     setState(() {
        //       items = FirebaseFirestore.instance.collection("Items").where('ItemName', arrayContains: _searchQuery).snapshots();
        //     });
        //     //print(_searchQuery.text);
        //   },
        //
        //   builder: (context, snapshot) {
        //     // setState(() {
        //     //   items = FirebaseFirestore.instance.collection("Items").where('ItemName', arrayContains: _searchQuery.text).snapshots();
        //     // });
        //
        //     // return StreamBuilder<QuerySnapshot> (
        //     //   stream: items,
        //     //   builder: (
        //     //       BuildContext context,
        //     //       AsyncSnapshot<QuerySnapshot> snapshot,
        //     //       ){
        //     //     if(snapshot.hasError){
        //     //       return Text("Something went wrong");
        //     //     }
        //     //     if(snapshot.connectionState == ConnectionState.waiting){
        //     //       return Text("Loading...");
        //     //     }
        //     //
        //     //     final data1 = snapshot.requireData;
        //     //
        //     //     return ListView.builder(
        //     //       //scrollDirection: Axis.vertical,
        //     //       //physics: ScrollPhysics(),
        //     //       //physics: NeverScrollableScrollPhysics(),
        //     //       itemBuilder: (context, index){
        //     //         return Column(
        //     //           mainAxisSize: MainAxisSize.min,
        //     //           children: <Widget>[
        //     //             ListTile(
        //     //               title: Text(data1.docs[index]['ItemName']),
        //     //             ),
        //     //           ],
        //     //         );
        //     //       },
        //     //       shrinkWrap: true,
        //     //       itemCount: data1.size,
        //     //     );
        //     //   },
        //     // );
        //
        //   },
        // ),
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
  Widget buildCard(BuildContext context, DocumentSnapshot document){
    final _item = document.get('ItemName');
    final _price = document.get('Price');

    return Container(
      child: Card(
        elevation: 4.0,
        child: InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(_item),
                    subtitle: Text(_price.toString()),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: <Widget>[
                //       TextButton(
                //         child: const Text('BUY'),
                //         onPressed: () {/* ... */},
                //       ),
                //       const SizedBox(width: 8),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );

  }
}



