import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mygame/Challenge.dart';
import 'package:mygame/main.dart';

class NoLimitMode extends StatefulWidget {
  NoLimitMode({Key key}) : super(key: key);
  @override
  NoLimitModeState createState() => NoLimitModeState();
}

class NoLimitModeState extends State<NoLimitMode> {
  TextEditingController mycontroller = TextEditingController();
  var programword;
  // ignore: non_constant_identifier_names
  var hint_word_given;
  var mytry = 0;
  @override
  void initState() {
    super.initState();
    programword = (words..shuffle()).first;
    hint_word_given = programword.split('');
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Timer timer = Timer(Duration(milliseconds: 4000), () {
        Navigator.of(context, rootNavigator: true).pop();
      });
      showDialog(
          context: context,
          builder: (_) => new AlertDialog(
              content: textDisplayWidget(
                  "Hey! I have a 4 letter word in my mind, Can you guess it?",
                  context,
                  Colors.black))).then((value) {
        // dispose the timer in case something else has triggered the dismiss.
        timer?.cancel();
        timer = null;
      });
    });
  }

  final _formKey = GlobalKey<FormState>();
  var bullCount = 0;
  var cowCount = 0;
  var timeLeft = 0;

  // ignore: non_constant_identifier_names
  String StatusMsg = "";
  List words = [
    'life',
    'love',
    'near',
    'ring',
    'wolf',
    'fish',
    'five',
    'king',
    'over',
    'time',
    'able',
    'have',
    'sing',
    'star',
    'city',
    'soul',
    'rich',
    'duck',
    'film',
    'lion',
    'live',
    'safe',
    'pain',
    'rain',
    'Sion',
    'iron',
    'once',
    'with',
    'fire',
    'care',
    'cake',
    'back',
    'lady',
    'work',
    'self',
    'mole',
    'golf',
    'Mary'
  ];

  int times = 10;
  // ignore: non_constant_identifier_names
  int Hint_coint = 1;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // ignore: non_constant_identifier_names
  pre_step(playerword) {
    // ignore: non_constant_identifier_names
    var word_list = playerword.split('');
    // ignore: non_constant_identifier_names
    var word_list1 = word_list.toSet().toList();
    var len = word_list1.length;
    if (len == 4) {
      return 1 == 1;
    } else {
      return [
        print(
            'Please enter the word exactly 4 letters or enter a word without duplicate letters'),
        1 == 2
      ];
    }
  }

  // ignore: always_declare_return_types
  // ignore: non_constant_identifier_names

  playGame(TextEditingController mycontroller, String action) {
    // var obj = ChallengeModeState();
    // ignore: unused_local_variable
    var gameStatus = "";

    // ignore: non_constant_identifier_names

    print('PLease guess the word  ');
    var input = mycontroller.value.text;
    // ignore: omit_local_variable_types
    String playerword = input.toUpperCase();

    if (playerword.toUpperCase() == programword.toUpperCase()) {
      //  gameStatus = 'hooray you guessed right!!!';
      setState(() {
        this.StatusMsg = gameStatus = 'hooray you guessed right!!!';
      });
      // ignore: unused_local_variable
      Timer timer = Timer(Duration(milliseconds: 4000), () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MyApp()),
            (route) => route.isCurrent);
      });
      print('hooray you guessed right!!!');
    } else if (action == 'SHOW') {
      setState(() {
        this.StatusMsg = gameStatus =
            'I Won the game!!! :) and the word is \"' + programword + '\"';
      });
      print('I Won the game!!! :) and the word is \"' + programword + '\"');
      // ignore: unused_local_variable
      Timer timer = Timer(Duration(milliseconds: 2000), () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MyApp()),
            (route) => route.isCurrent);
      });
    } else if (action == 'HINT') {
      // ignore: non_constant_identifier_names
      print('hintttttttttttttt----' + hint_word_given.toString() + programword);
      //print("${hint_word_given}, ${Hint_coint}");
      if (Hint_coint <= 3) {
        var hintword = (hint_word_given..shuffle()).first;
        if (hint_word_given.contains(hintword)) {
          hint_word_given.remove(hintword);
          Hint_coint += 1;
          print('Here your Hint Letter ' + hintword);
          setState(() {
            this.StatusMsg = 'Here your Hint Letter ' + hintword;
          });
        }
      } else {
        print('You reached maximum Hint');
        setState(() {
          this.StatusMsg = 'You reached maximum Hint';
        });
      }
    } else {
      // obj.tipsmethod(playerword, programword);
      // ignore: always_declare_return_types

      var programwordposdict = {};
      var playerwordposdict = {};
      var programwordpos = 1;
      var playerwordpos = 1;
      var bull = 0;
      var cow = 0;

      for (var i in programword.split('')) {
        programwordposdict[programwordpos] = i;
        programwordpos += 1;
      }
      for (var i1 in playerword.split('')) {
        if ((programword.toUpperCase()).contains(i1.toUpperCase())) {
          playerwordposdict[playerwordpos] = i1;
        }
        playerwordpos += 1;
      }

      for (var e in playerwordposdict.entries) {
        for (var f in programwordposdict.entries) {
          if (e.value.toUpperCase() == f.value.toUpperCase()) {
            if (e.key == f.key) {
              bull += 1;
            } else {
              cow += 1;
            }
          }
        }
      }

      mytry += 1;

      setState(() {
        this.bullCount = bull;
        this.cowCount = cow;
        this.timeLeft = mytry;
      });

      print(
          'your word have $bull Bulls and $cow cows and $times times left to find');
    }
  }

// ignore: non_constant_identifier_names
  Widget AlertWidgetMethod(BuildContext context) {
    return AlertDialog(
      content: textDisplayWidget(
          "Are you sure want to exit?", context, Colors.black),
      actions: <Widget>[
        // ignore: deprecated_member_use
        FlatButton(
          child: Text('Yes'),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MyApp()),
                (route) => route.isCurrent);
          },
        ),
        // ignore: deprecated_member_use
        FlatButton(
          child: Text('No'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: appWidget(this.context),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    textDisplayWidget("No Limit Mode", context, Colors.black),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textDisplayWidget(
                          "Turns Left: ${this.times == 0 ? "0" : this.timeLeft.toString()}",
                          context,
                          Colors.black),
                      IconButton(
                        icon: Icon(Icons.cancel_rounded),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertWidgetMethod(context));
                        },
                        iconSize: 40,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
                  child: Form(
                    key: _formKey,
                    child: Column(children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width - 40,
                          child: TextFormField(
                            controller: mycontroller,
                            decoration: InputDecoration(
                                labelText: 'Word',
                                labelStyle: TextStyle(
                                  fontWeight: FontWeight.w800,
                                ),
                                hintText: 'Please enter LETTERS only'),
                            maxLength: 4,
                            maxLines: 1,
                            // ignore: missing_return
                            validator: (mycontroller) {
                              if (mycontroller.contains(RegExp(r'[0-9]')) ||
                                  mycontroller.contains(new RegExp(
                                      r'[!@#$+/~%^&*()_,.?":{}|<>-]'))) {
                                print('text contain number');
                                return 'Input contains special characters or numbers';
                              } else if (mycontroller.length == 4) {
                                // ignore: non_constant_identifier_names
                                var word_list = mycontroller.split('');
                                // ignore: non_constant_identifier_names
                                var word_list1 = word_list.toSet().toList();
                                var len = word_list1.length;
                                if (len == 4) {
                                } else {
                                  return 'Please enter word without duplicate letters';
                                }
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) {
                              var flag = _formKey.currentState.validate();
                              print(mycontroller.value.text.length);
                              if (flag && mycontroller.value.text.length == 4) {
                                playGame(mycontroller, "");
                              }
                            },
                          ))
                    ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textDisplayWidget('Bull: ${this.bullCount.toString()}',
                          context, Colors.grey),
                      textDisplayWidget('Cow: ${this.cowCount.toString()}',
                          context, Colors.grey)
                    ],
                  ),
                ),
                Container(
                    padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
                    child: Text(
                      '${this.StatusMsg}',
                      textAlign: TextAlign.right,
                      style: GoogleFonts.montserrat(
                        textStyle: Theme.of(context).textTheme.button,
                        fontWeight: FontWeight.w200,
                        fontStyle: FontStyle.italic,
                        color: Colors.black,
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: EdgeInsets.all(25),
                        // ignore: deprecated_member_use
                        child: FlatButton(
                          padding: EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          child:
                              textDisplayWidget("Hint", context, Colors.white),
                          color: Color(0xff4e9570),
                          textColor: Colors.white,
                          onPressed: () {
                            playGame(mycontroller, 'HINT');
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(25),
                        // ignore: deprecated_member_use
                        child: FlatButton(
                          padding: EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          child:
                              textDisplayWidget("Show", context, Colors.white),
                          color: Color(0xff4e9570),
                          textColor: Colors.white,
                          onPressed: () {
                            playGame(mycontroller, 'SHOW');
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  validateInput(String mycontroller) {
    if (mycontroller.contains(RegExp(r'[0-9]')) ||
        mycontroller.contains(new RegExp(r'[!@#$+/~%^&*()_,.?":{}|<>-]'))) {
      print('text contain number');
      return true;
    } else {
      return false;
    }
  }
}
