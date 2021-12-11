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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.greenAccent,
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 200),
            alignment: Alignment.center,
            child: Center(
                child: Column(
              children: [
                //Container remplaccer par SizeBox
                SizedBox(
                    width: 350.0,
                    height: 200,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 10,
                      child: Column(
                        children: [
                          Row(children: [
                            const Text("Username :",
                                style: TextStyle(fontSize: 20.0)),
                            SizedBox(
                              width: 200.0,
                              child: Form(
                                  child: TextFormField(
                                style: const TextStyle(fontSize: 20.0),
                                decoration: const InputDecoration(
                                  hintText: 'Enter your username',
                                ),
                                onChanged: (value) => {username = value},
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                              )),
                            ),
                          ]),
                          padding(),
                          Row(children: [
                            const Text("PassWord :",
                                style: TextStyle(fontSize: 20.0)),
                            SizedBox(
                              width: 200.0,
                              child: Form(
                                  child: TextFormField(
                                style: const TextStyle(fontSize: 20.0),
                                decoration: const InputDecoration(
                                  hintText: 'Enter your password',
                                ),
                                onChanged: (value) => {password = value},
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  } else {
                                    password = value;
                                    print(password);
                                  }
                                  return null;
                                },
                              )),
                            ),
                          ]),
                          TextButton(
                              onPressed: () => {appelApi() /*PageAccueil()*/},
                              child: const Text("Connexion"))
                        ],
                      ),
                    )),
                TextButton(
                    onPressed: () => {PageInscription()},
                    child: const Text('Inscription'))
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

  void PageAccueil(int id, String statut) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(id: id, statut: statut),
        ));
  }

  void appelApi() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/api/etudiants'));
    if (response.statusCode == 200) {
      // print(jsonDecode(response.body)["hydra:member"]);
      var etds = jsonDecode(response.body);
      // var etds = jsonDecode(response.body)["hydra:member"];
      bool connection = false;
      // print(etds);
      for (var etudiant in etds) {
        Etudiant etd = Etudiant.fromJson(etudiant);
        if (username == etd.username && password == etd.password) {
          connection = true;
          PageAccueil(etd.id, etd.statut_benef);
        }
      }
      if (!connection) {
        Erreur();
      }
    } else {
      print('Erreur');
    }
  }
}

padding() {
  return const Padding(padding: EdgeInsets.only(top: 10.0, bottom: 10.0));
}
