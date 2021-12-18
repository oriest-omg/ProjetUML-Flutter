import 'package:flutter/material.dart';
import 'package:porjet_uml/model/etudiant.dart';
import 'package:porjet_uml/widgets/home_page.dart';
import 'inscription_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Connexion extends StatefulWidget {
  const Connexion({Key? key}) : super(key: key);

  @override
  _ConnexionState createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {
  late String username = '';
  late String password;
  late String api = 'http://10.0.2.2:8000/api/etudiants';
      // late String api = 'http://192.168.43.130:8000/api/etudiants';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF07996D),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 50),
            alignment: Alignment.center,
            child: Center(
                child: Column(
              children: [
                padding(),
                Image.asset(
                  'images/logo.png',
                  fit: BoxFit.fill,
                ),
                padding(),
                padding(),
                padding(),
                padding(),
                SizedBox(
                      child: Column(
                        children: [
                          champ('email', TypeTextField.email, TextInputType.emailAddress),
                          padding(),
                          champ('mot de passe', TypeTextField.password, TextInputType.visiblePassword),
                          padding(),
                          Text('mot de passe oublié ?',style: TextStyle(
                              fontSize: 25.0,
                              color: Colors.white
                          )),
                          TextButton(
                              onPressed: () => {appelApi() /*PageAccueil()*/},
                              style: ButtonStyle(
                                foregroundColor: MaterialStateProperty.all(Colors.white),
                              ),
                              child: const Text("Connexion",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0
                              ),))
                        ],
                      ),
                    ),
                padding(),
                TextButton(
                    onPressed: () => {PageInscription()},
                    child: const Text('Inscription',style: TextStyle(
                      color: Colors.white
                    ),))
              ],
            )),
          ),
        ));
  }

  void PageInscription() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => InscriptionPage()),
    );
  }

  void Erreur() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        action: SnackBarAction(
          textColor: Colors.red,
          label: 'Erreur',
          onPressed: () {
            // Code to execute.
          },
        ),
        content: const Text('Erreur de connexion'),
        duration: const Duration(milliseconds: 1500),
        // width:280.0,// Width of the SnackBar.
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0, // Inner padding for SnackBar content.
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  void PageAccueil(int id, String statut, String niveau, String filiere) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(id: id, statut: statut,niveau: niveau,filiere: filiere,),
        ));
  }

  void appelApi() async {
    print('ok');
    final response =
        await http.get(Uri.parse(api));
    if (response.statusCode == 200) {
      print('1ok');
      // print(jsonDecode(response.body)["hydra:member"]);
      var etds = jsonDecode(response.body);
      // var etds = jsonDecode(response.body)["hydra:member"];
      bool connection = false;
      // print(etds);
      for (var etudiant in etds) {
        Etudiant etd = Etudiant.fromJson(etudiant);
        if (username == etd.email && password == etd.password) {
          connection = true;
          PageAccueil(etd.id, etd.statut_benef,etd.niveauBenef,etd.filiereBenef);
        }
      }
      if (!connection) {
        Erreur();
      }
    } else {
      print('Erreur');
    }
  }

  champ(String titre, TypeTextField type, TextInputType inputType) {
    return Center(
      // Icon(iconn),
      child :SizedBox(
          width: MediaQuery.of(context).size.width - 50,
          // width: 300.0,
          child: Column(
            children: [
              Container(
                width: 400.0,
                margin: EdgeInsets.only(right: 50.0,bottom: 10.0),
                child:Text(titre,style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white
                ),),
              ),
              Form(
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(36)),
                    child: TextField(
                      keyboardType: inputType,
                      decoration: InputDecoration(
                        hintText: titre,
                        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                      ),
                      onChanged: (value) async {
                        switch (type) {
                          case TypeTextField.email:
                            username = value;
                            break;
                          case TypeTextField.password:
                            password = value;
                            break;
                        }
                      },
                    )),
              )
            ],
          ),
          ),
    );
  }
}

padding() {
  return const Padding(padding: EdgeInsets.only(top: 10.0, bottom: 10.0));
}
enum TypeTextField {
email,
  password
}