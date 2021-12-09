import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:grizz_connect/quiz_brain.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:grizz_connect/quiz.dart';

QuizBrain quizBrain = QuizBrain();

class MyForm extends StatefulWidget {
    @override
    _MyForm createState() => _MyForm();
}

class _MyForm extends State<MyForm> {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.amber,
                title: const Text(
                    'Health Questionnaire',
                    style: TextStyle(
                        fontSize: 29.0,
                        fontWeight: FontWeight.bold,
                    ),
                ),
                centerTitle: true,
            ),
            body: SafeArea(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                        Text(
                            'Check and see if its safe for you to meet with others',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 40.0,
                                color: Colors.brown.shade900,
                            ),
                        ),
                        RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: [
                                TextSpan(
                                    style: TextStyle(
                                        fontSize: 30.0,
                                        color: Colors.black,
                                    ),
                                    text: "To contact Graham Health Center"),
                                TextSpan(
                                    style: TextStyle(
                                        fontSize: 30.0,
                                        color: Colors.blue,
                                    ),
                                    text: " click here",
                                    recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                            var url = "https://www.oakland.edu/ghc";
                                            launch(url);
                                        }),
                            ])),
                        RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: [
                                TextSpan(
                                    style: TextStyle(
                                        fontSize: 30.0,
                                        color: Colors.black,
                                    ),
                                    text: "To find test sites local to you"),
                                TextSpan(
                                    style: TextStyle(
                                        fontSize: 30.0,
                                        color: Colors.blue,
                                    ),
                                    text: " click here",
                                    recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                            var url = "https://goo.gl/maps/iyYKCMjWSCVEWrNVA";
                                            launch(url);
                                        }),
                            ])),
                        RaisedButton(
                            padding: EdgeInsets.all(15.0),
                            elevation: 5.0,
                            color: Colors.amber,
                            onPressed: () {
                                Navigator.pushNamed(context, 'quiz');
                            },
                            child: Text(
                                'Start Questionnaire',
                                style: TextStyle(fontSize: 40.0, color: Colors.black),
                            ),
                        )
                    ],
                ),
            ),
        );
    }
}