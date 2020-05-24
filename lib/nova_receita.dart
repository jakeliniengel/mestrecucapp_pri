import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mestrecucapp/model/usuario.dart';

class NovaReceita extends StatefulWidget {
  final Usuario user;

  const NovaReceita({Key key, @required this.user}) : super(key: key);

  @override
  _NovaReceitaState createState() => _NovaReceitaState();
}

class _NovaReceitaState extends State<NovaReceita> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextStyle style = TextStyle(fontSize: 20, color: Colors.white);
  File _image;
  var bytes = null;
  var photo = null;
  //Campos
  String _categoria;
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _tempo_prepController = TextEditingController();
  final TextEditingController _porcoesController = TextEditingController();
  final TextEditingController _ingredientesController = TextEditingController();
  final TextEditingController _modo_prepController = TextEditingController();


  //Função para inserir imagem na receita
  void _pickImage() async {
    final imageSource = await showDialog<ImageSource>(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text("Origem da Foto"),
              actions: <Widget>[
                MaterialButton(
                  child: Text("Câmera"),
                  onPressed: () => Navigator.pop(context, ImageSource.camera),
                ),
                MaterialButton(
                  child: Text("Galeria"),
                  onPressed: () => Navigator.pop(context, ImageSource.gallery),
                )
              ],
            )
    );

    if(imageSource != null) {
      final file = await ImagePicker.pickImage(source: imageSource, maxHeight: 200, maxWidth: 150);
      if(file != null) {
        setState(() => _image = file);
        if(_image!=null) {
          bytes = await _image.readAsBytes();
          photo = base64.encode(bytes);
        }

      }
    }
  }
  void Dialogo(String titulo, String descricao){
    showDialog(
        context: context,
        builder:  (BuildContext context) {
          return AlertDialog(
            title: Text(titulo),
            content: Text(descricao),
            actions: <Widget>[
              FlatButton(
                child: Text("Ok"),
                onPressed: (){
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Adicionar receita"),
      ),

      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child:Container(
            padding: const EdgeInsets.only(top: 36,left: 30, right: 30, bottom: 30),
            color: Colors.black,
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //Escolher imagem para a receita
                SizedBox(
                    height: 140,
                    child: Center(
                        child:  Container(
                          width: MediaQuery.of(context).size.width*.4,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white
                          ),
                          child: InkWell(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(150.0),
                              child: _image==null?Padding( padding: EdgeInsets.all(30),child: Icon(Icons.add_a_photo, color: Colors.grey, size: 80,),) : Image.file(_image, fit: BoxFit.cover, width: 150, height: 150,),
                            ),
                            //child:

                            onTap: _pickImage,
                          ),

                        )
                    )
                ),
                SizedBox(
                  height: 45,
                ),
                //Título
                TextFormField(
                  obscureText: false,
                  style: style,
                  controller: _tituloController,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Informe um título para a receita';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                    labelText:  'Título',
                    labelStyle: TextStyle(fontSize: 16),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32), ),
                    enabledBorder:  OutlineInputBorder(borderSide: BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(32), ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                //Descrição
                TextFormField(
                  obscureText: false,
                  style: style,
                  controller: _descricaoController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                    labelText:  'Descrição',
                    labelStyle: TextStyle(fontSize: 16),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32), ),
                    enabledBorder:  OutlineInputBorder(borderSide: BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(32), ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                //Tempo de preparo e porções
                Row(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width*.5,
                      child: TextFormField(
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        style: style,
                        controller: _tempo_prepController,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 2.0, style: BorderStyle.solid), borderRadius: BorderRadius.circular(32), ),
                            enabledBorder:  OutlineInputBorder(borderSide: BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(32), ),
                            labelText:  'Tempo prep.(Min)',
                            labelStyle: TextStyle(fontSize: 16)
                        ),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Informe um valor válido';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width*.01,
                      child: Text(""),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width*.29,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        obscureText: false,
                        style: style,
                        controller: _porcoesController,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 2.0, style: BorderStyle.solid), borderRadius: BorderRadius.circular(32), ),
                            enabledBorder:  OutlineInputBorder(borderSide: BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(32), ),
                            labelText:  'Porções',
                            labelStyle: TextStyle(fontSize: 16)
                        ),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Informe um valor válido';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                //Ingredientes
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  obscureText: false,
                  controller: _ingredientesController,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Informe um valor válido';
                    }
                    return null;
                  },
                  style: style,
                  minLines: 2,
                  maxLines: 50,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                    labelText:  'Ingredientes',
                    labelStyle: TextStyle(fontSize: 16),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32), ),
                    enabledBorder:  OutlineInputBorder(borderSide: BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(32), ),
                  ),
                ),
                Center(
                  child: Text(
                    "Separe os ingredientes por ' ; ' \nEx.: 1 xícara farinha; 2 ovos;",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                //Modo de preparo
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _modo_prepController,
                  obscureText: false,
                  style: style,
                  minLines: 4,
                  maxLines: 50,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Informe um valor válido';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                    labelText:  'Modo de preparo',
                    labelStyle: TextStyle(fontSize: 16),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32), ),
                    enabledBorder:  OutlineInputBorder(borderSide: BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(32), ),
                  ),
                ),
                Center(
                  child: Text(
                    "Separe as orientações por ' ; '\nEx.: Misture os ingredintes secos; Bata as claras em neve;",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                //Categoria
                SizedBox(
                  height: 15,
                ),
                DropdownButton<String>(
                  hint: Text("Categoria"),
                  value: _categoria,
                  icon: Icon(Icons.fastfood),
                  iconSize: 24,
                  elevation: 25,
                  isExpanded: true,
                  style: TextStyle(color: Colors.pinkAccent),
                  underline: Container(
                    height: 2,
                    width: MediaQuery.of(context).size.width*.8,
                    color: Colors.white,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      _categoria = newValue;
                    });
                  },
                  items: <String>['Frituras', 'Sobremesas', 'Assados', 'Bolos e tortas', 'Bebidas quentes','Cupcacke', 'Biscoitos e bolachas', 'Bebidas geladas', 'Comida fitness', 'Sorvetes']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 25,
                ),

                RaisedButton(
                  padding: EdgeInsets.all(20),
                  color: Colors.pinkAccent,
                  child: Container(
                    width: MediaQuery.of(context).size.width*.85,
                    child: Text('Salvar', style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
                  ),
                  focusColor: Color(0xFFCF9F77),
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                      side: BorderSide(color: Colors.pink)
                  ),
                  elevation: 7.0,
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      Firestore.instance.collection("receitas").add(
                          {
                            "titulo" : _tituloController.text,
                            "descricao" : _descricaoController.text,
                            "ingredientes": _ingredientesController.text.split(";"),
                            "modo_preparo": _modo_prepController.text.split(";"),
                            "tempo" : _tempo_prepController.text,
                            "porcoes": _porcoesController.text,
                            "categoria": _categoria,
                            "foto": photo,
                            "data": DateTime.now().toUtc(),
                            "autor": widget.user.nome
                          }
                      ).then((e){
                       Dialogo("Inserido com sucesso", "Sua receita de ${_tituloController.text} foi salva com sucesso!");
                      }).catchError((onError){
                        Dialogo("Erro", "Não foi posível salvar a receita na base de dados. Tente mais tarde!");
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
