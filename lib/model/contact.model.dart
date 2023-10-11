import 'dart:convert';

class Contact{
  static String table="contact";

  int? id;
  String? prenom;
  String? nom;


  int? tel;


  Contact({this.id,this.prenom,this.nom,this.tel});
  static Contact fromJson(Map<String, dynamic> json){
    return Contact(
      id:json['id'],prenom:json['prenom'].toString(),nom:json['nom'].toString(),tel:json['tel']
  );
  }
  Map<String ,dynamic> toJson(){
    return{
      'id':id,
      'prenom':prenom,
      'nom':nom,

      'tel':tel
  };

  }

}