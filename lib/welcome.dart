import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class MyWelcome extends StatefulWidget {
  @override
  _MyWelcomeState createState() => _MyWelcomeState();

}

class _MyWelcomeState extends State<MyWelcome> {

  final List<String> _listItem = [
    'Home.png',
    'Person.jpg',
    'Settings.png',
    'Health.png',
  ];

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
                  height: 250,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                          image: AssetImage('Login.jpg'),
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
                        const Text("Hello Golden Grizzly", style: TextStyle(color: Colors.yellow, fontSize: 35, fontWeight: FontWeight.bold),),
                        Container(
                          height: 55,
                          margin: EdgeInsets.symmetric(horizontal: 40),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white
                          ),
                          child: Center(child: Text("Select from Menu below", style: TextStyle(color: Colors.grey[900], fontWeight: FontWeight.bold),)),
                        ),
                        SizedBox(height: 30,),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
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
                            child: Transform.translate(
                              offset: Offset(50, -50),
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 65, vertical: 63),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white
                                ),
                                child: Icon(Icons.bookmark, size: 29,),
                              ),

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
                            child: Transform.translate(
                              offset: Offset(50, -50),
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 65, vertical: 63),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white
                                ),
                                child: Icon(Icons.bookmark, size: 29,),
                              ),

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
                            child: Transform.translate(
                              offset: Offset(50, -50),
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 65, vertical: 63),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white
                                ),
                                child: Icon(Icons.bookmark, size: 29,),
                              ),

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
                            child: Transform.translate(
                              offset: Offset(50, -50),
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 65, vertical: 63),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white
                                ),
                                child: Icon(Icons.bookmark, size: 29,),
                              ),

                            ),
                          ),
                          onTap:(){},
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