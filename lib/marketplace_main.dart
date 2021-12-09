import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grizz_connect/upload.dart';
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

  bool _showBackToTopButton = false;
  ScrollController _scrollController = ScrollController();

  late Future resultsLoaded;
  List _allResults = [];
  List _resultsList = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _scrollController.addListener(() {
      setState(() {
        if (_scrollController.offset >= 400) {
          _showBackToTopButton = true;
        } else {
          _showBackToTopButton = false;
        }
      });
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _scrollController.dispose();
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

    try{
      var data = await FirebaseFirestore.instance
          .collection('Items')
          .get();

      setState(() {
        _allResults = data.docs;
      });

      print(_allResults);
      print("Retrieved items");

      searchResultsList();
      return "complete";

    }catch(error){
      print(error);
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Could not retrieve items. Try again!'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    };

  }

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: Duration(milliseconds: 400), curve: Curves.linear);
  }

  // getItemsStreamSnapshots() async {
  //   final FirebaseAuth _auth = FirebaseAuth.instance;
  //   final user = _auth.currentUser;
  //   final userid = user!.uid.toString();
  //
  //   var collection = FirebaseFirestore.instance.collection('Items');
  //   collection.snapshots().listen((querySnapshot) {
  //     print(querySnapshot.docs);
  //      setState(() {
  //            _allResults = querySnapshot.docs;
  //          });
  //      print("hello");
  //     print(_allResults);
  //   });
  //
  //   searchResultsList();
  //   return "complete";
  // }

  @override
  Widget build(BuildContext context) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.grey,
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
        SingleChildScrollView(
          controller: _scrollController,
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
                      Container(
                        child: Column(children: [
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  _filterController.text = 'Books';
                                  filterResultsList();
                                });
                              },
                              child: const Icon(
                                Icons.book,
                                color: Colors.amber,
                                size: 100,
                              )
                          ),
                          const Text('Books',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black),
                          )
                        ]
                        ),
                      ),
                      Column(children: [
                        TextButton(
                            onPressed: () {
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
                        const Text('Furniture',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black),)
                      ]),
                      Column(children: [
                        TextButton(
                            onPressed: () {
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
                        const Text('Electronics',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black),)
                      ]),
                      Column(children: [
                        TextButton(
                            onPressed: () {
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
                        const Text('Lab Kits',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black),)
                      ]),
                      Column(children: [
                        TextButton(
                            onPressed: () {
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
                        const Text('Supplies',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black),)
                      ]),
                      // Column(children: [
                      //   TextButton(
                      //       onPressed: () {
                      //         setState(() {
                      //           _filterController.text = 'Favorites';
                      //           filterResultsList();
                      //         });
                      //       },
                      //       child: const Icon(
                      //         Icons.favorite,
                      //         color: Colors.amber,
                      //         size: 100,
                      //       )),
                      //   const Text('Favorites',
                      //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black),)
                      // ]),
                    ],
                  ),
                ),

                //Clear Filter and refresh buttons
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, left: 3.5),
                            child: ElevatedButton(
                              child: const Text('Clear selection'),
                              style: OutlinedButton.styleFrom(
                                primary: Colors.black,
                                backgroundColor: Colors.amber,
                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                side: const BorderSide(color: Colors.amber),
                              ),
                              onPressed: () {
                                setState(() {
                                  _searchController.clear();
                                  _filterController.clear();
                                  filterResultsList();
                                  //getItemsStreamSnapshots();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, left: 3.5),
                            child: ElevatedButton(
                              child: const Text('Refresh'),
                              style: OutlinedButton.styleFrom(
                                primary: Colors.black,
                                backgroundColor: Colors.amber,
                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                side: const BorderSide(color: Colors.amber),
                              ),
                              onPressed: () {
                                setState(() {
                                  getItemsStreamSnapshots();
                                });
                              },
                            ),
                          ),
                        ],
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

        // Floating '+' button
        Padding(
          padding: const EdgeInsets.only(bottom: 15, right: 8.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: 75.0,
              height: 75.0,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => UploadItem())
                  );
                },
                child: const Icon(Icons.add, color: Colors.black,),
                backgroundColor: Colors.amber,
                elevation: 10.0,
                heroTag: null,
              ),
            ),
          ),
        ),
      ]),

      // Scroll to Top Button
      floatingActionButton: _showBackToTopButton == false
          ? null
          : FloatingActionButton(
        onPressed: _scrollToTop,
        child: const Icon(Icons.arrow_circle_up),
        backgroundColor: Colors.black,
        elevation: 10.0,
        heroTag: null,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      // Original Floating '+' button
      // floatingActionButton: SizedBox(
      //   width: 75.0,
      //   height: 75.0,
      //   child: FloatingActionButton(
      //     onPressed: () {
      //       Navigator.push(
      //           context, MaterialPageRoute(builder: (context) => UploadItem())
      //       );
      //     },
      //     child: const Icon(Icons.add, color: Colors.black,),
      //     backgroundColor: Colors.amber,
      //     elevation: 10.0,
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

    );
  }
  Widget buildCard(BuildContext context, DocumentSnapshot document){
    final _item = document.get('ItemName');
    final _price = document.get('Price');
    final _image = document.get('imageURL');

    return Container(
      // padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      height: 250,
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
                  height: 170,
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
                        subtitle: Text('\$${_price.toString()}'),
                      ),
                    ),
                    // BUY button
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 28, right: 15),
                          child:  const Text('VIEW',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),),
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
