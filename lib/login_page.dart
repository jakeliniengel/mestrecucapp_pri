import 'package:flutter/material.dart';
import 'package:mestrecucapp/home_page.dart';
import 'package:mestrecucapp/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mestrecucapp/model/usuario.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextStyle style = TextStyle(fontSize: 20, color: Colors.white);
  final frmLoginKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final databaseReference = Firestore.instance;

  bool _success;
  String _userEmail;
  void _signInWithEmailAndPassword() async{
    final FirebaseUser user = (await _auth.signInWithEmailAndPassword(
    email: _emailController.text,
    password: _passwordController.text,
    )).user;
    if (user != null) {
      Usuario info_usuario = await getUsuario(_emailController.text);
      print(info_usuario.nome);
      setState(() {
        _success = true;
        _userEmail = user.email;
      });
      Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context)=>HomePage(user: info_usuario)), ModalRoute.withName('/HomePage'));
    }else {
      _success = false;
      Error();
    }
  }
  void Error(){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("Erro"),
            content: Text("Usuário e/ou senha incorretos!"),
            actions: <Widget>[
              FlatButton(
                child: Text("Ok"),
                onPressed: ()=>Navigator.pop(context),
              )
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    final usuarioField= TextFormField(
      obscureText: false,
      style: style,
      controller: _emailController,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Informe um email  válido';
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        labelText:  'Email',
        labelStyle: TextStyle(fontSize: 16),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32), ),
        enabledBorder:  OutlineInputBorder(borderSide: BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(32), ),
      ),
    );
    final senhaField= TextFormField(
      controller: _passwordController,
      obscureText: true,
      style: style,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Informe a senha';
        }
        return null;
      },
      decoration: InputDecoration(
        fillColor: Colors.white,
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 2.0, style: BorderStyle.solid), borderRadius: BorderRadius.circular(32), ),
        enabledBorder:  OutlineInputBorder(borderSide: BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(32), ),
        labelText:  'Senha',
        labelStyle: TextStyle(fontSize: 16)
      ),
    );
    return Scaffold(
        body: SingleChildScrollView(
          child: Center(
              child: Container(

                height: MediaQuery.of(context).size.height,
                color: Colors.black,
                child: Padding(
                    padding: const EdgeInsets.all(36),
                    child: Form(
                      key: frmLoginKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 155,
                            child: Image.asset('assets/images/logo.png'),
                          ),
                          SizedBox(
                            height: 45,
                          ),
                          usuarioField,
                          SizedBox(
                            height: 15,
                          ),
                          senhaField,
                          SizedBox(
                            height: 25,
                          ),
                          RaisedButton(
                            padding: EdgeInsets.all(20),
                            color: Colors.pinkAccent,
                            child: Container(
                              width: MediaQuery.of(context).size.width*.85,
                              child: Text('LOGIN', style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
                            ),
                            focusColor: Color(0xFFCF9F77),
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0),
                                side: BorderSide(color: Colors.pink)
                            ),
                            elevation: 7.0,
                            onPressed: () async{
                              if (frmLoginKey.currentState.validate()) {
                                _signInWithEmailAndPassword();
                              }
                              if(!_success){
                                Error();
                              }
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),

                          SizedBox(
                            height: 15,
                          ),
                          FlatButton(
                              onPressed: () => showDialog(
                                  context: context,
                                  builder: (context) {
                                    return RegisterPage();
                                  }
                              ),
                              child: Text('Registre-se',
                                  style: TextStyle(fontSize: 25, color:Color(0xFFffffff),)
                              )
                          )
                        ],
                      ),
                    )
                ),
              )
          ),
        )
    );
  }
}
