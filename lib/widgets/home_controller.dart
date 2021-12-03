import 'package:flutter/material.dart';
import 'InscriptionPage.dart';

class Connexion extends StatefulWidget {
  const Connexion({Key? key}) : super(key: key);

  @override
  _ConnexionState createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: Container(
        margin : EdgeInsets.only(top: 200),
        alignment: Alignment.center,
        child : Center(
          child: Column(
        children: [
          //Container remplaccer par SizeBox
          SizedBox(
              width: 350.0,
              height: 200,
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),),
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
                            hintText: 'Enter your username',
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        )),
                      ),
                    ]),
                    TextButton(onPressed: ()=>{}, child: Text("Connexion"))
                  ],
                ),
              )),
          TextButton(onPressed: () => { PageInscription()}, child: Text('Inscription'))
        ],
      )),
        ),
    );
  }
  void PageInscription()
  {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => InscriptionPage()),
    );
  }

}

padding() {
  return const Padding(padding: EdgeInsets.only(top: 10.0, bottom: 10.0));
}
