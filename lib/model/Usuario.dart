import 'package:cloud_firestore/cloud_firestore.dart';
class Usuario{
  final id;
  final email;
  final nome;
  final foto;
  Usuario({this.email, this.nome, this.foto, this.id});
  factory Usuario.fromJson(Map<String, dynamic> json)=> Usuario(
    email: json['email'],
    nome: json['nome'],
    foto: json['foto'],
  );
}
Future<Usuario> getUsuario(email) async{
  return await Firestore.instance.collection("usuarios").document(email).get().then((DocumentSnapshot ds){
    return Usuario.fromJson(ds.data);
  });
}