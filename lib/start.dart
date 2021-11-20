import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class MyStart extends StatefulWidget {


  @override
  _MyStartState createState() => _MyStartState();

}

class _MyStartState extends State<MyStart> {

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
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

            onPressed: () => Navigator.pushNamed(context, 'login'),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          //key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                //validator: (val) => val.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                obscureText: true,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                  child: const Text(
                    'Sign In',
                  ),
                  onPressed: () async {
                    print(email);

                    String emailDomain = '';
                    if(email.length > 11) {
                      emailDomain = email.substring((email.length - 12));
                    }
                    if(email.length < 12) {
                      print('invalid email');
                    }
                    print('domain is: ' + emailDomain);
                    if( emailDomain !="@oakland.edu"){
                      print('invalid, must be oakland university email');
                    }

                  }
              ),

            ],
          ),
        ),
      ),
    );
  }
}