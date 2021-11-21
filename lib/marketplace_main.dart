import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:grizz_connect/testing.dart';
import 'package:grizz_connect/upload.dart';
import 'package:grizz_connect/main.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:flutter/material.dart';

class MarketplaceTab extends StatefulWidget {
  const MarketplaceTab({Key? key}) : super(key: key);

  @override
  _MarketplaceState createState() => _MarketplaceState();
}

class _MarketplaceState extends State<MarketplaceTab> {
  //final fsInstance = FirebaseFirestore.instance;
  int selectedPage = 0;

  _onTap() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => _pageOptions[selectedPage]));
  }
  // pages options for bottom navigation bar
  final _pageOptions = [
    //otherPage(),
    Testing(),
    //otherPage()
  ];

  final Stream<QuerySnapshot> items = FirebaseFirestore.instance.collection("Items").snapshots();

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final user = _auth.currentUser;
    final userid = user!.uid.toString();

    return Scaffold(
      body: Stack(fit: StackFit.expand, children: [
        buildFloatingSearchBar(),
        SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.only(top: 140, right:20, left: 20),
            child: //<Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
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
                            onPressed: () {},
                            child: const Icon(
                              Icons.book,
                              color: Colors.amber,
                              size: 100,
                            )),
                        const Text('Books')
                      ]),
                      Column(children: [
                        TextButton(
                            onPressed: () {},
                            child: const Icon(
                              Icons.chair,
                              color: Colors.amber,
                              size: 100,
                            )),
                        const Text('Furniture')
                      ]),
                      Column(children: [
                        TextButton(
                            onPressed: () {},
                            child: const Icon(
                              Icons.computer,
                              color: Colors.amber,
                              size: 100,
                            )),
                        const Text('Electronics')
                      ]),
                      Column(children: [
                        TextButton(
                            onPressed: () {},
                            child: const Icon(
                              Icons.science_sharp,
                              color: Colors.amber,
                              size: 100,
                            )),
                        const Text('Lab Kits')
                      ]),
                      Column(children: [
                        TextButton(
                            onPressed: () {},
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

                // Item cards column
                //SizedBox(
                  //padding: const EdgeInsets.all(20.0),
                  //height: 500,
                  //child:
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

                            return ListView.builder(
                                //scrollDirection: Axis.vertical,
                                //physics: ScrollPhysics(),
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: data.size,
                                itemBuilder: (context, index){
                                  // return Text('Name: ${data.docs[index]['ItemName']}, Price: ${data.docs[index]['Price']}');
                                  return Card(
                                    elevation: 4.0,
                                    child: Column(
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
                                              onPressed: () {/* ... */},
                                            ),
                                            const SizedBox(width: 8),

                                          ],
                                        ),
                                      ],
                                    )

                                    ,
                                  );
                                },
                            );
                         },
                  ),
                ),

              ] // Column Children
                  ),
        //]
        ),
      ]),
      // Floating '+' button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => UploadItem()));
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.amber,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      // Bottom Navigation Bar
      extendBody: true, //show body behind nav bar
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(top: 0, bottom: 10),
          child: DotNavigationBar(
            backgroundColor: Colors.black,
            dotIndicatorColor: Colors.white,
            unselectedItemColor: Colors.grey[300],
            selectedItemColor: Colors.amber,
            items: [
              DotNavigationBarItem(
                icon: const Icon(Icons.sell),
              ),
              DotNavigationBarItem(
                icon: const Icon(Icons.health_and_safety),
              ),
              DotNavigationBarItem(
                icon: const Icon(Icons.settings),
              ),
            ],
            currentIndex: selectedPage,
            onTap: (index) {
              setState(() {
                selectedPage = index;
              });
              _onTap();
            },
          )),
    );
  }

  // search bar with profile button
  Widget buildFloatingSearchBar() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      hint: 'Search Item...',
      scrollPadding: const EdgeInsets.only(top: 10, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      borderRadius: BorderRadius.circular(30),
      debounceDelay: const Duration(milliseconds: 500),
      automaticallyImplyDrawerHamburger: true,
      onQueryChanged: (query) {
        // Call your model, bloc, controller here - A callback that gets invoked when the input of the query inside the TextField changed.
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: SlideFadeFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          // profile icon showed when search is closed
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {}, //go to profile when clicked
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          //clears search when search bar is closed
          showIfClosed: false,
        ),
      ],
      // List of search results shown below search bar
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: Colors.accents.map((color) {
                return Container(height: 112, color: color);
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}

