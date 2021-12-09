import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:grizz_connect/login.dart';
import 'package:grizz_connect/marketplace_main.dart';
import 'package:grizz_connect/modifylist.dart';
import 'package:grizz_connect/quiz.dart';
import 'package:grizz_connect/user_list.dart';
import 'package:grizz_connect/register.dart';
import 'package:grizz_connect/start.dart';
import 'package:grizz_connect/welcome.dart';
import 'package:grizz_connect/pro.dart';
import 'package:grizz_connect/modifylist.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyLogin(),
    routes: {
      'register': (context) => MyRegister(),
      'login': (context) => MyLogin(),
      'start': (context) => MyStart(),
      'user_list': (context) => profileInfo(),
      'pro' : (context) => MyForm(),
      'quiz' : (context) => Quiz(),
      'marketplace_main' : (context) => MarketplaceTab(),
      'welcome' : (context) => MyWelcome(),
      'modifylist' : (context) => ModifyListTab(),
    },
  ));
}