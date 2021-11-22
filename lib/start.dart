import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class MyStart extends StatefulWidget {


  @override
  _MyStartState createState() => _MyStartState();

}

class _MyStartState extends State<MyStart> {

  final List<String> _listItem = [
    'home.png',
    'profile1.jpg',
    'settings.png',
    'health.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[600],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // leading: Icon(Icons.menu),
        title: Center( child: Text('  Home',textAlign: TextAlign.center,),),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              width: 36,
              height: 30,
              decoration: BoxDecoration(
                  color: Colors.grey[600],
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Center(child: Text("0")),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: AssetImage('Login.jpg'),
                        fit: BoxFit.cover
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
                          decoration: BoxDecoration(color: Colors.greenAccent,
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: AssetImage('home.png'),

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
                              child: Icon(Icons.bookmark_border, size: 10,),
                            ),

                          ),
                        ),
                        onTap:(){print ("tapped");},
                      ),


                      InkWell(
       child: Container(
          decoration: BoxDecoration(color: Colors.greenAccent,
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                  image: AssetImage('health.png'),

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
              child: Icon(Icons.bookmark_border, size: 10,),
            ),

          ),
        ),
        onTap:(){print ("tapped");},
        ),



                      InkWell(
                        child: Container(
                          decoration: BoxDecoration(color: Colors.greenAccent,
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: AssetImage('profile1.jpg'),

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
                              child: Icon(Icons.bookmark_border, size: 10,),
                            ),

                          ),
                        ),
                        onTap:(){print (Colors.black12);},
                      ),

                      InkWell(
                        child: Container(
                          decoration: BoxDecoration(color: Colors.greenAccent,
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: AssetImage('settings.png'),

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
                              child: Icon(Icons.bookmark_border, size: 10,),
                            ),

                          ),
                        ),
                        onTap:(){print ("tapped");},
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
