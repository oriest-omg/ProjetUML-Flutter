import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:porjet_uml/model/etudiant.dart';
import 'package:porjet_uml/widgets/connexion_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.id,required this.statut}) : super(key: key);
  final int id;
  final String statut;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Etudiant> etudiant;

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    etudiant = getData();
  }

  @override
  Widget build(BuildContext context) {
        return (widget.statut == "actif")
            ? Scaffold(
            backgroundColor: Colors.green,
            appBar: AppBar(),
            body: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // TextButton(onPressed: () => {getData()}, child: Text('oklm')),
                    SizedBox(
                      child: FutureBuilder<Etudiant>(
                        future: etudiant,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var etd = snapshot.data;
                            return (etd!.statut_benef == "actif")
                                ? Column(
                              children: [
                                Card(
                                  child: Image.network(
                                    'http://10.0.2.2:8000/' + etd.photo,
                                    width: 100.0,
                                  ),
                                ),
                                Text('nom : ' + etd.username),
                                Text('email : ' + etd.email)
                              ],
                            )
                                : (etd.statut_benef == "en cours")
                                ? StatuEnCours()
                                : Text('chargement');
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }
                          // By default, show a loading spinner.
                          return const CircularProgressIndicator();
                        },
                      ),
                    ),
                  ],
                )))
            : (widget.statut == "en cours")
            ? StatuEnCours()
            : Erreur();
  }

  Future<Etudiant> getData() async {
    if (widget.id != null) {
      final response = await http.get(Uri.parse(
          'http://10.0.2.2:8000/api/etudiants/' + widget.id.toString()));
      if (response.statusCode == 200) {
        Etudiant etd = Etudiant.fromJson(jsonDecode(response.body));
        return etd;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load etudiant data');
      }
    } else {
      throw Exception('not id');
    }
  }

  StatuEnCours() {
    return Scaffold(
        backgroundColor: Colors.green,
        body: SizedBox(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // TextButton(onPressed: () => {getData()}, child: Text('oklm')),
            SizedBox(
              child: FutureBuilder<Etudiant>(
                future: etudiant,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var etd = snapshot.data;
                    return SizedBox(
                        child: Center(
                            child: Column(
                      children: [
                        const Padding(padding: EdgeInsets.only(top: 200.0)),
                        const Text(
                          "Merci de repasser plus tard ",
                          textAlign: TextAlign.center,
                          textScaleFactor: 2.2,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          "nous étudions votre dossier",
                          textAlign: TextAlign.center,
                          textScaleFactor: 2.2,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          "vous recevrez une confirmation d'inscription dans un delais de 72h,",
                          textAlign: TextAlign.center,
                          textScaleFactor: 2.2,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 80.0)),
                        ElevatedButton(
                          onPressed: () => {PageConnexion()},
                          child: const Text(
                            'Retour',
                            textScaleFactor: 1.5,
                          ),
                          style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.all(Colors.green),
                            fixedSize: MaterialStateProperty.all(
                                Size.fromWidth(100.0)),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.greenAccent),
                            elevation: MaterialStateProperty.all(10.0),
                          ),
                        )
                      ],
                    )));
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                },
              ),
            ),
          ],
        )));
  }

  Erreur() {
    return Scaffold(
          backgroundColor: Colors.green,
          body: SizedBox(
        child: Center(
            child: Column(
      children: [
        Padding(padding: const EdgeInsets.only(top: 40.0)),
        const Text(
          "Erreur",
          textAlign: TextAlign.center,
          textScaleFactor: 3.2,
          style: TextStyle(
            color: Colors.red,
          ),
        ),
        Padding(padding: const EdgeInsets.only(top: 50.0)),
        const Text(
          "Nous avons détecter une erreur , si elle persiste veuillez contacter l'école merci",
          textAlign: TextAlign.center,
          textScaleFactor: 2.2,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 100.0)),
        ElevatedButton(
          onPressed: () => {PageConnexion()},
          child: Text(
            'Retour',
            textScaleFactor: 1.5,
          ),
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.green),
            fixedSize: MaterialStateProperty.all(Size.fromWidth(100.0)),
            backgroundColor: MaterialStateProperty.all(Colors.greenAccent),
            elevation: MaterialStateProperty.all(10.0),
          ),
        )
      ],
    ))));
  }

  void PageConnexion() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Connexion()),
    );
  }
}
