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
  int selectedPage = 0;
  _onTap(){
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => _pageOptions[selectedPage]));
  }

  final _pageOptions = [
    UploadItem(),
    Testing(), // update to covid health form page
    //settings() //add settings page
  ];

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final user = _auth.currentUser;
    final userid = user!.uid.toString();

    return Scaffold(
      body: Stack(
          fit: StackFit.expand,
          children: [
            buildFloatingSearchBar(),
            Container(
                padding: const EdgeInsets.only(top: 140),
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                    ] // Column Children
                )),
          ]
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => UploadItem()));
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.amber,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
            onTap: (index){
              setState(() {
                selectedPage = index;
              });
              _onTap();
            },
          )
      ),
    );
  }

  // search bar with profile button
  Widget buildFloatingSearchBar() {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      hint: 'Search Item...',
      scrollPadding: const EdgeInsets.only(top: 10, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      borderRadius: BorderRadius.circular(30) ,
      debounceDelay: const Duration(milliseconds: 500),
      automaticallyImplyDrawerHamburger: true,
      onQueryChanged: (query) {
        // Call your model, bloc, controller here - A callback that gets invoked when the input of the query inside the TextField changed.
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: SlideFadeFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction( // profile icon showed when search is closed
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {}, //go to profile when clicked
          ),
        ),
        FloatingSearchBarAction.searchToClear( //clears search when search bar is closed
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


// Card buildCard(heading, price, image, date, context) {
//   var supportingText =
//       'Beautiful home to rent, recently refurbished with modern appliances...';
//   return Card(
//       elevation: 4.0,
//       child: Column(
//         children: [
//           ListTile(
//             title: Text(heading),
//             subtitle: Text(date),
//             trailing: Icon(Icons.favorite_outline),
//           ),
//           Container(
//             height: 200.0,
//             child: Ink.image(
//               image: image,
//               fit: BoxFit.cover,
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.all(16.0),
//             alignment: Alignment.centerLeft,
//             child: Text(price),
//           ),
//           InkWell(
//             onTap: () {},
//             splashColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
//             highlightColor: Colors.transparent,
//           )
//           // ButtonBar(
//           //   children: [
//           //     TextButton(
//           //       child: const Text('CONTACT AGENT'),
//           //       onPressed: () {/* ... */},
//           //     ),
//           //     TextButton(
//           //       child: const Text('LEARN MORE'),
//           //       onPressed: () {/* ... */},
//           //     )
//           //   ],
//           // )
//         ],
//       ));
// }


// Container(
//     height: 300,
//     child:
//     ListView(
//       //scrollDirection: Axis.vertical,
//       children: [
//         Column(
//           children: [
//             Expanded(child:
//             Card(
//               elevation: 4.0,
//               child: Column(
//                 children: [
//                   const ListTile(
//                     title: Text('Computer for sale'),
//                     subtitle: Text('Nov 4, 2021'),
//                     trailing: Icon(Icons.favorite_outline),
//                   ),
//                   Container(
//                     height: 200.0,
//                     child: Ink.image(
//                       image: image1,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.all(16.0),
//                     alignment: Alignment.centerLeft,
//                     child: Text('\$2300.00'),
//                   ),
//                   InkWell(
//                     onTap: () {},
//                     splashColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
//                     highlightColor: Colors.transparent,
//                   )
//                 ],
//               )
//           )),
//             Expanded(child:
//               Card(
//                 elevation: 4.0,
//                 child: Column(
//                   children: [
//                     const ListTile(
//                       title: Text('College Physics Textbook'),
//                       subtitle: Text('Nov 1, 2021'),
//                       trailing: Icon(Icons.favorite_outline),
//                     ),
//                     Container(
//                       height: 200.0,
//                       child: Ink.image(
//                         image: image2,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     Container(
//                       padding: EdgeInsets.all(16.0),
//                       alignment: Alignment.centerLeft,
//                       child: const Text('\$50.00'),
//                     ),
//                     InkWell(
//                       onTap: () {},
//                       splashColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
//                       highlightColor: Colors.transparent,
//                     )
//                   ],
//                 )
//             )),
//             Expanded(child:
//               Card(
//                 elevation: 4.0,
//                 child: Column(
//                   children: [
//                     const ListTile(
//                       title: Text('Nike Air Backpack'),
//                       subtitle: Text('Oct 30, 2021'),
//                       trailing: Icon(Icons.favorite_outline),
//                     ),
//                     Container(
//                       height: 200.0,
//                       child: Ink.image(
//                         image: image3,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     Container(
//                       padding: EdgeInsets.all(16.0),
//                       alignment: Alignment.centerLeft,
//                       child: const Text('\$20.00'),
//                     ),
//                     InkWell(
//                       onTap: () {},
//                       splashColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
//                       highlightColor: Colors.transparent,
//                     )
//                   ],
//                 )
//               ))
//             ],
//     )]))