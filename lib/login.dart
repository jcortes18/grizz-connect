import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  String email = '', pass = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('Login.jpg'), fit: BoxFit.cover
        ),
      ),
      child: Scaffold(

        backgroundColor: Colors.black12,
        body: Stack(
          children: [
            Container(),
            Container(
              padding: const EdgeInsets.only(left: 42, top: 95),
              child: const Text(
                'GRIZZ             CONNECT',

                style: TextStyle(color: Colors.white, fontSize: 32,
                    fontWeight: FontWeight.w700),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          TextFormField(
                            onChanged: (val) {
                              setState(() => email = val);
                            },
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Email",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          TextFormField(
                            onChanged: (val) {
                              setState(() => pass = val);
                            },
                            style: const TextStyle(),
                            obscureText: true,
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Password",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text(
                                ' Sign in ',
                                style: TextStyle(color: Colors.black,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700,
                                  backgroundColor: Color.fromRGBO(254, 215, 102, 2),
                                ),
                              ),
                              CircleAvatar(
                                radius: 32,
                                backgroundColor: const Color(0xff4c505b),
                                child: IconButton(
                                    iconSize: 42,
                                    color: const Color.fromRGBO(254, 215, 102, 2),
                                    onPressed: () async {
                                      setState(() { error = '';});
                                      if (email.isEmpty || pass.isEmpty) {
                                        setState(() => error = ' All fields required ');
                                      }
                                      //else if(!email.endsWith('@oakland.edu')) {
                                      //  setState(() => error = ' Wrong email ');
                                      //}
                                      else if(email.isNotEmpty && pass.isNotEmpty){
                                        //setState(()  => error = '');
                                        try {
                                        UserCredential userCredential = await FirebaseAuth
                                            .instance
                                            .signInWithEmailAndPassword(
                                            email: email, password: pass);
                                            //print(userCredential);
                                            //print(userCredential.user);
                                            Navigator.pushNamed(context, 'welcome');
                                      } on FirebaseAuthException catch (e) {
                                        if (e.code == 'user-not-found') {  //or use invalid_email
                                          setState(() => error = ' Email not found ');
                                        } else if (e.code == 'wrong-password') {
                                          setState(() => error = ' Wrong password provided ');
                                        }
                                      }
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.arrow_forward,
                                    )
                                ),
                              )

                            ],
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, 'register');
                                },
                                child: const Text(
                                  ' New User? Register! ',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.black,
                                      fontSize: 32,
                                      backgroundColor: Color.fromRGBO(254, 215, 102, 2)
                                  ),
                                ),
                                style: const ButtonStyle(),
                              ),

                              /*  TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    'Forgot Password',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.amberAccent,
                                      fontSize: 18,
                                    ),
                                  )
                              ),
                            */
                            ],
                          ),
                          const SizedBox(height: 10.0),
                          Text(''+error+'',
                              style: const TextStyle(
                              color: Colors.red, fontSize: 25.0, backgroundColor: Colors.white,
                                  fontWeight: FontWeight.w700)
                          )
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

