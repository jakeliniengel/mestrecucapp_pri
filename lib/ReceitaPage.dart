import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Receita extends StatefulWidget {
  final cod;
  Receita({
    Key key,
    @required this.cod
}): super(key: key);

  @override
  _ReceitaState createState() => _ReceitaState();
}

class _ReceitaState extends State<Receita> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Nome da receita",),
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(5),

        child:  Column(

          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset("assets/images/bolo.jpg", width: 200.0, fit: BoxFit.cover,),
            Text("Nome da receita"),
            Text("Data: 0102/2020"),
            Text("Tempo de preparo: 30 min"),
            Text("Porção: 10"),
            Text("Descrição"),
            Text("Ingredientes:"),
            Row(
              children: <Widget>[
                Checkbox(

                  value: false,
                  activeColor: Colors.lightBlue,
                ),
                Text("Farinha")
              ],
            ),
            Text("Modo de preparo"),


          ],
        ),
      )
    );
  }
}
