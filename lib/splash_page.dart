
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {


  void navegarTelaLogin(){
    Navigator.pushNamedAndRemoveUntil(context, '/LoginPage' ,ModalRoute.withName('/LoginPage'));
  }
  iniciarSplash() async{
    var _duracao = Duration(seconds: 3);
    return new Timer(_duracao, navegarTelaLogin);
  }
  @override
  void initState(){
    super.initState();
    iniciarSplash();
  }
  @override
  Widget build(BuildContext context) {

    SystemChrome.setEnabledSystemUIOverlays([]);
    return Container(
        width: MediaQuery.of(context).size.width*1.0,
        height: MediaQuery.of(context).size.height*1.0,
        decoration: BoxDecoration(
          color: Colors.black,

        ),
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/images/logo.png', width: 200,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Carregando', style: TextStyle(color: Color(0xFFCF9F77), fontSize: 35, ),
                  ),

                ],
              )
            ],
          ),
        )
    );
  }
}