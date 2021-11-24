import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grizz_connect/pro.dart';
import 'package:grizz_connect/quiz_page.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:grizz_connect/welcome.dart';
class Quiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: QuizPage(),
        ),
      ),
    );
  }
}
