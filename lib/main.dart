import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:grizz_connect/login.dart';
import 'package:grizz_connect/marketplace_main.dart';
import 'package:grizz_connect/register.dart';
import 'package:grizz_connect/start.dart';
import 'package:grizz_connect/upload.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
    home: MyLogin(),
    routes: {
      'register': (context) => MyRegister(),
      'login': (context) => MyLogin(),
      'start': (context) => MarketplaceTab(),
    },
  ));
}
