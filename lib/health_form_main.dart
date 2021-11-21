import 'package:flutter/gestures.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:url_launcher/url_launcher.dart';

QuizBrain quizBrain = QuizBrain();

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => formHomePage(),
      '/second': (context) => Quiz(),
    },
  ));
}

class formHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          'Health Questionnaire',
          style: TextStyle(
            fontSize: 35.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('images/bgImg.jpg'),
              colorFilter: ColorFilter.mode(
                Colors.grey.withOpacity(0.5),
                BlendMode.dstATop,
              ),
            ),
          ),
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
                text: TextSpan(
                  children: [
                    TextSpan(
                      style : TextStyle(
                        fontSize: 30.0,
                        color:Colors.black,

                    ),
                    text:"To contact Graham Health Center"),
                    TextSpan(
                        style : TextStyle(
                          fontSize: 30.0,
                          color:Colors.blue,

                        ),
                        text:" click here",
                      recognizer: TapGestureRecognizer()..onTap = (){
                          var url = "https://www.oakland.edu/ghc/home";
                          launch(url);
                          }
                    ),

                  ]

                )
              ),
              RaisedButton(
                padding: EdgeInsets.all(15.0),
                elevation: 5.0,
                color: Colors.lightGreen.shade200,
                onPressed: () {
                  Navigator.pushNamed(context, '/second');
                },
                child: Text(
                  'Start Questionnaire',
                  style: TextStyle(fontSize: 40.0, color: Colors.red),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

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

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];
  int countCorrectAns = 0;
  int totalNoOfQuestions = quizBrain.getCountOfQuestions();

  void checkAnswer(BuildContext context, bool userAns) {
    setState(() {
      if (quizBrain.getAnswer() == userAns) {
        scoreKeeper.add(
          Icon(
            Icons.check,
            color: Colors.green,
          ),
        );
        countCorrectAns++;
      } else {
        scoreKeeper.add(
          Icon(
            Icons.close,
            color: Colors.red,
          ),
        );
      }

      if (quizBrain.isFinished()) {
        if (countCorrectAns == totalNoOfQuestions) {
          Alert(
            closeFunction: () => Navigator.pop(context),
            context: context,
            type: AlertType.success,
            title: "Hurray!",
            desc:
            "You answered $countCorrectAns/$totalNoOfQuestions questions correctly. It is safe for you to meet with others",
            buttons: [
              DialogButton(
                child: Text(
                  "Exit the questionnaire",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                width: 200,
              )
            ],
          ).show();
        } else {
          Alert(
            closeFunction: () => Navigator.pop(context),
            context: context,
            type: AlertType.error,
            title: "Oh No!",
            desc:
            "You answered $countCorrectAns/$totalNoOfQuestions questions correctly. Please consult a Physician or GHS about possible COVID exposure.",
            buttons: [
              DialogButton(
                child: Text(
                  "Exit the Questionnaire",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                width: 200,
              )
            ],
          ).show();
        }

        quizBrain.reset();
        scoreKeeper.clear();
        countCorrectAns = 0;
      } else {
        quizBrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestion(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'Yes',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkAnswer(context, true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'No',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(context, false);
              },
            ),
          ),
        ),
        Expanded(
          child: Row(
            children: scoreKeeper,
          ),
        )
      ],
    );
  }
}