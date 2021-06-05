import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mygame/Challenge.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  debugDisableShadows = false;
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primaryColor: Color(0xff4e9570)),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
