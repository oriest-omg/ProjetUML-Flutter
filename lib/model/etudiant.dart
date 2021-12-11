class Etudiant {
  // late String id;
  // late String type;
  int id;
   String username;
   String password;
   String photo;
   String email;
   String bac_benef;
   String statut_benef;


  Etudiant({
    required this.id,
    required this.username,
    required this.password,
    required this.photo,
    required this.email,
    required this.bac_benef,
    required this.statut_benef
  });
  factory Etudiant.fromJson(Map <String,dynamic> json){
    return Etudiant(
      id :json['id'],
      username : json['username'],
      password :json['password'],
      photo : json['photo'],
      email: json['email'],
      bac_benef: json['bacBenef'],
      statut_benef: json['statutBenef'],

    );
  }

}