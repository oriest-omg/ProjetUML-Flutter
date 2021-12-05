import 'dart:convert';

import 'package:http/http.dart' as http;


class Etudiant {
  late String id;
  late String type;
  late int hydraMemberId;
  late String username;
  late String password;

  Etudiant(this.id,this.type,this.hydraMemberId,this.username, this.password);
  factory Etudiant.fromJson(dynamic json){
    return Etudiant(
      json["@id"],
      json["@type"],
      json['id'],
      json['username'],
      json['password'],
    );
  }

}