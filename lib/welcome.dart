import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class MyWelcome extends StatefulWidget {
  @override
  _MyWelcomeState createState() => _MyWelcomeState();
}

class _MyWelcomeState extends State<MyWelcome> {

  final List<String> _listItem = [
    'Home.png',
    'Person.jpg',
    'Settings.png',
    'Health.png','property.png','map.png',
  ];
  bool _showBackToTopButton = false;
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
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
  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: Duration(milliseconds: 400), curve: Curves.linear);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[600],
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        elevation: 0,
        title: const Center( child: Text('Home',
          style: TextStyle(fontSize: 25,fontWeight: FontWeight.w900),
        ),),


        actions: <Widget>[
          TextButton.icon(
            icon: const Icon(Icons.logout,
              color: Colors.black,
              size: 32,
            ),
            label: const Text('',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            onPressed: () => Navigator.pushNamed(context, 'login'),
          ),
        ],
      ),
      body: SafeArea(
          child: Container(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                          image: AssetImage('ou.png'),
                          fit: BoxFit.fitWidth
                      )
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                            begin: Alignment.bottomRight,
                            colors: [
                              Colors.black.withOpacity(.4),
                              Colors.black.withOpacity(.2),
                            ]
                        )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          height: 55,
                          margin: EdgeInsets.symmetric(horizontal: 40),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white
                          ),
                          child: Center(child: Text("Hello Golden Grizzly", style: TextStyle(color: Colors.grey[900], fontWeight: FontWeight.bold),)),
                        ),
                        SizedBox(height: 5,),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      shrinkWrap: true,
                      children: <Widget>[

                        InkWell(
                          child: Container(
                            decoration: BoxDecoration(color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                image: const DecorationImage(
                                    image: AssetImage('Home.png'),

                                    fit: BoxFit.contain
                                )
                            ),
                          ),
                          onTap:(){
                            Navigator.pushNamed(context, 'marketplace_main');
                          },
                        ),


                        InkWell(
                          child: Container(
                            decoration: BoxDecoration(color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                image: const DecorationImage(
                                    image: AssetImage('Health.png'),
                                    fit: BoxFit.fitHeight
                                )
                            ),

                          ),
                          onTap:(){
                            Navigator.pushNamed(context, 'pro');
                          },
                        ),



                        InkWell(
                          child: Container(
                            decoration: BoxDecoration(color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                image: const DecorationImage(
                                    image: AssetImage('Person.jpg'),
                                    fit: BoxFit.cover
                                )
                            ),

                          ),
                          onTap:(){
                            Navigator.pushNamed(context, 'start');
                          },
                        ),

                        InkWell(
                            child: Container(
                              decoration: BoxDecoration(color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  image: const DecorationImage(
                                      image: AssetImage('Settings.png'),

                                      fit: BoxFit.cover
                                  )
                              ),

                            ),
                            onTap:() async{
                              var url = "https://mysail.oakland.edu/uPortal/f/welcome/p/academic-resources.u17l1n11/max/render.uP?pCp";
                              if (await launch(url)) {
                                await launch(url);
                              } else {
                                throw 'Could not launch $url';
                              }}
                        ),
                        InkWell(
                            child: Container(
                              decoration: BoxDecoration(color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  image: const DecorationImage(
                                      image: AssetImage('property.png'),
                                      fit: BoxFit.cover
                                  )
                              ),

                            ),
                            onTap:() async{
                              var url = "https://oakland.edu/universityservices/property-management/";
                              if (await launch(url)) {
                                await launch(url);
                              } else {
                                throw 'Could not launch $url';
                              }}
                        ),
                        InkWell(
                            child: Container(
                              decoration: BoxDecoration(color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  image: const DecorationImage(
                                      image: AssetImage('map.png'),
                                      fit: BoxFit.cover
                                  )
                              ),

                            ),
                            onTap:() async{
                              var url = "https://map.concept3d.com/?id=566#!ct/0";
                              if (await launch(url)) {
                                await launch(url);
                              } else {
                                throw 'Could not launch $url';
                              }}
                        ),

                      ],

                    )
                )
              ],

            ),
          )),
    );

  }
}