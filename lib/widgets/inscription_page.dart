import 'package:flutter/material.dart';

class InscriptionPage extends StatefulWidget {
  const InscriptionPage({Key? key}) : super(key: key);

  @override
  _InscriptionPageState createState() => _InscriptionPageState();
}

class _InscriptionPageState extends State<InscriptionPage> {
  late String nomBenef = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: SizedBox(child: Text("Inscription"),)),
      body: SingleChildScrollView(
        child : Container(
          child: Column(
            children: [
              padding(),
              champ("Nom :", nomBenef,Icons.eleven_mp),
              padding(),
              champ("Prenom :", nomBenef,Icons.eleven_mp),
              padding(),
              champ("Sexe :", nomBenef,Icons.eleven_mp),
              padding(),
              champ("Date de naissance :", nomBenef,Icons.eleven_mp),
              padding(),
              champ("Lieu de naissance :", nomBenef,Icons.eleven_mp),
              padding(),
              champ("Email :", nomBenef,Icons.eleven_mp),
              padding(),
              champ("Telephone-Etudiant :", nomBenef,Icons.eleven_mp),
              padding(),
              champ("Telephone-Parent :", nomBenef,Icons.eleven_mp),
              Text("Ecole"),
              padding(),
              champ("Diplome obtenu :", nomBenef,Icons.eleven_mp),
              padding(),
              champ("Filière souhaité :", nomBenef,Icons.eleven_mp),
            ],
          ),
        ),
      )
    );
  }
}

champ(String titre,String valeurChamp, IconData iconn){
  return Row(children: [
    Icon(iconn),
     Text(titre,
        style: TextStyle(fontSize: 20.0)),
    SizedBox(
      width: 200.0,
      child: Form(
          child: TextFormField(
            style: const TextStyle(fontSize: 20.0),
            decoration: const InputDecoration(
              hintText: 'Enter your password',
            ),
            onChanged: (value)=>{
              valeurChamp = value
            },
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          )),
    ),
  ]);
}
padding() {
  return const Padding(padding: EdgeInsets.only(top: 10.0, bottom: 10.0));
}

