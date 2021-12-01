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
  TextEditingController _searchController = TextEditingController();
  TextEditingController _filterController = TextEditingController();

  late Future resultsLoaded;
  List _allResults = [];
  List _resultsList = [];
  int selectedPage = 0;

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

                ] // Column Children
              ),

        ),

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
    );
  }
  Widget buildCard(BuildContext context, DocumentSnapshot document){
    final _item = document.get('ItemName');
    final _price = document.get('Price');
    final _image = document.get('imageURL');

    return Container(
      // padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      height: 230,
      width: 350,
      child: Card(
        elevation: 4.0,
        child: InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => ItemPage(item: document)));
          },
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 150,
                  width: 350,
                  child: Image.network(_image,
                  fit: BoxFit.cover),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Item name and price
                    Expanded(
                      child: ListTile(
                        title: Text(_item),
                        subtitle: Text(_price.toString()),
                      ),
                    ),
                    // BUY button
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 15),
                          child: TextButton(
                            child: const Text('VIEW'),
                            onPressed: () {

                            },
                          ),
                        ),
                        //const SizedBox(width: 4),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }
}



