// OLD Registration code

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  String userName = '';
  String email = '';
  String pass = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('Register.jpg'), fit: BoxFit.fitHeight),
      ),
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(240, 230, 140, 90),
        appBar: AppBar(
          title: const Text('GrizzConnect'),
          foregroundColor: Colors.black,
          backgroundColor: Colors.amberAccent,
          elevation: 20,
          actions: <Widget>[
            TextButton.icon(
              icon: const Icon(
                Icons.person,
                color: Colors.black,
                size: 27,
              ),
              label: const Text(
                'Login',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              onPressed: () => Navigator.pushNamed(context, 'login'),
            ),
          ],
        ),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 35, top: 30),
              child: const Text(
                '\n    Registration Form',
                style: TextStyle(color: Colors.black, fontSize: 32),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (val) {
                              if (val!.isNotEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            onChanged: (val) {
//validator: (val) => val.isEmpty ? 'Enter an email';
                              setState(() => userName = val);
                            },
                            style: const TextStyle(
                              color: Colors.black54,
                            ),
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                fillColor: Colors.amberAccent,
                                filled: true,
                                hintText: "Name",
                                hintStyle:
                                    const TextStyle(color: Colors.black54),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            onChanged: (val) {
                              setState(() => email = val);
                            },
                            style: const TextStyle(color: Colors.black54),
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                fillColor: Colors.amberAccent,
                                filled: true,
                                hintText: "Email",
                                hintStyle:
                                    const TextStyle(color: Colors.black54),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            onChanged: (val) {
                              setState(() => pass = val);
                            },
                            style: const TextStyle(color: Colors.black54),
                            obscureText: true,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                fillColor: Colors.amberAccent,
                                filled: true,
                                hintText: "Password",
                                hintStyle:
                                    const TextStyle(color: Colors.black54),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          const SizedBox(
                            height: 29, //height of signup and button
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text(
                                ' Sign Up ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 27,
                                    fontWeight: FontWeight.w700),
                              ),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: const Color(0xff4c505b),
                                child: IconButton(
                                    iconSize: 42,
                                    color:
                                        const Color.fromRGBO(254, 215, 102, 2),
                                    onPressed: () async {
                                      if (userName.isEmpty ||
                                          email.isEmpty ||
                                          pass.isEmpty) {
                                        setState(() =>
                                            error = ' All fields required ');
                                      } else if (!email
                                              .endsWith('@oakland.edu') ||
                                          email.length < 15) {
                                        setState(() => error =
                                            'Oakland University Email required ');
                                      }
// //{emailDomain = email.substring((email.length - 12));}

/*else {
                                        setState(() =>
                                        error = 'Error, Try again');
                                      }
                                      */
                                    },
                                    icon: const Icon(
                                      Icons.arrow_forward,
                                    )),
                              ),
                            ],
                          ),

/*
                          const SizedBox( //return to login
                            height: 50,
                          ),
                          Row(  //return
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {

                                  Navigator.pushNamed(context, 'login');
                                },
                                child: const Text(
                                  'Already have an account? Login!',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.black,
                                      fontSize: 20),
                                ),
                                style: const ButtonStyle(
                                ),
                              ),
                            ],
                          )
                          */

                          const SizedBox(height: 50.0),
                          Text(error,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w700,
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
