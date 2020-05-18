import 'package:flutter/material.dart';
import 'package:mestrecucapp/HomePage.dart';
import 'package:mestrecucapp/LoginPage.dart';
import 'package:mestrecucapp/SplashPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MestreCuca',
      theme: ThemeData(
        disabledColor: Colors.white,
          hintColor: Colors.white,
          accentColor: Colors.white,
          backgroundColor:Colors.black ,
          primaryColor: Color(0xFFCF9F77),
      ),
      home: SplashPage(),
      routes: <String, WidgetBuilder>{
        '/LoginPage': (BuildContext context) => LoginPage(),
        '/HomePage': (BuildContext context) => HomePage(),
      },
    );
  }
}
