import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:async/async.dart';
import 'package:path_provider/path_provider.dart';
import 'package:porjet_uml/model/etudiant.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

import 'home_page.dart';

class InscriptionPage extends StatefulWidget {
  const InscriptionPage({Key? key}) : super(key: key);

  @override
  _InscriptionPageState createState() => _InscriptionPageState();
}

class _InscriptionPageState extends State<InscriptionPage> {
  // late ScrollController _controller;


  late String nomBenef = '';
  late String prenomBenef = '';
  late String emailBenef = '';
  late String passwordBenef = '';
  late String photoBenef = '';
  late String bacBenef = '';
  late String filiereBenef = 'INFORMATIQUE';
  late String niveauBenef = 'LP1';
  late String matricule = '';
  late String sexe = 'Masculin';
  late String dateNaissance = '';
  late String lieuNaissance = '';
  late String telEtudiant = '';
  late String telParent = '';
  late String cni = '';
  final format = DateFormat("dd/MM/yyyy");


  void initState() {
    super.initState();
    // _controller = ScrollController();
    // _controller.addListener(_listener);
  }

  // @override
  //   void _listener() {
  //   if(_controller.offset >= _controller.position.maxScrollExtent && !_controller.position.outOfRange) {
  //     print('Je suis en bas !');
  //   }
  //
  //   if(_controller.offset <= _controller.position.minScrollExtent && !_controller.position.outOfRange) {
  //     print('Je suis en haut !');
  //   }
  // }
  // @override
  //   void dispose() {
  //   super.dispose();
  //   _controller.removeListener(_listener);
  // }
  final int _numPages = 4;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      print(_currentPage);
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.greenAccent : Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();

    return Scaffold(
        backgroundColor: Color(0xFF07996D),
        body: SingleChildScrollView(
          child : Column(
            children: [
                Container(
                  height: 550.0,
                  child:PageView(
                    /// [PageView.scrollDirection] defaults to [Axis.horizontal].
                    /// Use [Axis.vertical] to scroll vertically.
                    // controller: controller,
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children:  <Widget>[
                      Center(
                          child: Column(
                            children: [
                              padding(),
                              padding(),
                              padding(),
                              padding(),
                              padding(),
                              padding(),
                              padding(),
                              padding(),
                              padding(),
                              padding(),
                              Image.asset(
                                'images/logo.png',
                                fit: BoxFit.fill,
                              ),
                              padding(),
                              champ("Nom ", TypeTextField.nom, Icons.eleven_mp,TextInputType.name),
                              padding(),
                              champ("Prenom ", TypeTextField.prenom, Icons.eleven_mp,TextInputType.name),
                              padding(),
                              padding(),
                              champ("Email :", TypeTextField.email, Icons.eleven_mp,TextInputType.emailAddress),
                              padding(),
                              Container(
                                margin: EdgeInsets.only(right: 300.0,bottom: 10.0),
                                child:Text('Sexe',style: TextStyle(
                                    fontSize: 25.0,
                                    color: Colors.white
                                ),),
                              ),
                              Container(
                                  width: MediaQuery.of(context).size.width-50,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(36)),
                                  child: DropdownButton<String>(
                                    value: sexe,
                                    // icon: const Icon(Icons.arrow_downward),
                                    // iconSize: 24,
                                    // elevation: 16,
                                    style: const TextStyle(color: Colors.black,fontSize: 20.0),
                                    underline: Container(
                                      // height: 2,
                                      // color: Colors.deepPurpleAccent,
                                    ),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        sexe = newValue!;
                                      });
                                    },
                                    items: <String>['Masculin','Feminin']
                                        .map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  )
                              ),
                            ],
                          ),
                      ),
                      Center(
                        child: Column(
                          children: [
                            padding(),
                            padding(),
                            padding(),
                            padding(),
                            padding(),
                            padding(),
                            padding(),
                            padding(),
                            padding(),
                            padding(),
                            Image.asset(
                              'images/logo.png',
                              fit: BoxFit.fill,
                            ),
                            padding(),
                            // champ("Date de naissance ", TypeTextField.dateNaissance,
                            //     Icons.eleven_mp,TextInputType.datetime),
                        Center(
                          // Icon(iconn),
                          child :SizedBox(
                              width: MediaQuery.of(context).size.width - 50,
                              // width: 300.0,
                              child : Column(
                                children: [
                                  Container(
                                    width: 400.0,
                                    margin: EdgeInsets.only(right: 50.0,bottom: 10.0),
                                    child:Text('Date de naissance',style: TextStyle(
                                        fontSize: 25.0,
                                        color: Colors.white
                                    ),),
                                  ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(36)),
                                  child :DateTimeField(
                                    format: format,
                                    onShowPicker: (context, currentValue) {
                                      return showDatePicker(
                                          context: context,
                                          firstDate: DateTime(1900),
                                          initialDate: currentValue ?? DateTime.now(),
                                          lastDate: DateTime(2100));
                                    },
                                  ),
                              )],
                              )),
                        ),

                            padding(),
                            champ("Lieu de naissance ", TypeTextField.lieuNaissance,
                                Icons.eleven_mp,TextInputType.name),
                            padding(),
                            champ("Telephone-Etudiant ", TypeTextField.telEtudiant,
                                Icons.eleven_mp,TextInputType.phone),
                            padding(),
                            champ("Telephone-Parent ", TypeTextField.telParent,
                                Icons.eleven_mp,TextInputType.text),
                            padding(),
                          ],
                        ),
                      ),
                      Center(
                        child: Column(
                          children: [
                            padding(),
                            padding(),
                            padding(),
                            padding(),
                            padding(),
                            padding(),
                            padding(),
                            padding(),
                            padding(),
                            padding(),
                            Image.asset(
                              'images/logo.png',
                              fit: BoxFit.fill,
                            ),
                            padding(),
                            Container(
                              margin: EdgeInsets.only(right: 290.0,bottom: 10.0),
                              child:Text('Filiere',style: TextStyle(
                                  fontSize: 25.0,
                                  color: Colors.white
                              ),),
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width-50,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(36)),
                                child: DropdownButton<String>(
                                  value: filiereBenef,
                                  // icon: const Icon(Icons.arrow_downward),
                                  // iconSize: 24,
                                  // elevation: 16,
                                  style: const TextStyle(color: Colors.black,fontSize: 20.0),
                                  underline: Container(
                                    // height: 2,
                                    // color: Colors.deepPurpleAccent,
                                  ),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      filiereBenef = newValue!;
                                    });
                                  },
                                  items: <String>['INFORMATIQUE','TCF']
                                      .map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                )
                            ),
                            padding(),
                            Container(
                              margin: EdgeInsets.only(right: 280.0,bottom: 10.0),
                              child:Text('Niveau',style: TextStyle(
                                  fontSize: 25.0,
                                  color: Colors.white
                              ),),
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width-50,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(36)),
                                child: DropdownButton<String>(
                                  value: niveauBenef,
                                  // icon: const Icon(Icons.arrow_downward),
                                  // iconSize: 24,
                                  // elevation: 16,
                                  style: const TextStyle(color: Colors.black,fontSize: 20.0),
                                  underline: Container(
                                    // height: 2,
                                    // color: Colors.deepPurpleAccent,
                                  ),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      niveauBenef = newValue!;
                                    });
                                  },
                                  items: <String>['LP1','LP2','LP3','M1','M2']
                                      .map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                )
                            ),
                            padding(),
                            champ("mot de passe ", TypeTextField.mdp, Icons.eleven_mp,TextInputType.visiblePassword),
                            padding(),
                          ],
                        ),
                      ),
                      Center(
                        child: Column(
                          children: [
                            padding(),
                            padding(),
                            padding(),
                            padding(),
                            padding(),
                            padding(),
                            padding(),
                            padding(),
                            padding(),
                            padding(),
                            Image.asset(
                              'images/logo.png',
                              fit: BoxFit.fill,
                            ),
                            padding(),
                            Container(
                                margin: EdgeInsets.only(left: 30.0),
                                child: Row(
                                  children: [
                                    Text('Fichier Cni :',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0
                                      ),),
                                    IconButton(
                                        icon: Icon(Icons.photo_library),
                                        onPressed: (() => getCni(ImageSource.gallery))),
                                    (cni == '')?Container():Text('fichier ajouté')
                                  ],
                                )),
                            Container(
                                margin: EdgeInsets.only(left: 30.0),
                                child: Row(
                                  children: [
                                    Text('Fichier Bac :',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0
                                      ),),
                                    IconButton(
                                        icon: Icon(Icons.photo_library),
                                        onPressed: (() => getImage(ImageSource.gallery))),
                                    (bacBenef == '')?Container():Text('fichier ajouté')
                                  ],
                                )),
                            padding(),
                            Container(
                              margin: const EdgeInsets.only(right: 200.0,bottom: 10.0),
                              child:const Text('Insérer photo',style: TextStyle(
                                  fontSize: 25.0,
                                  color: Colors.white
                              ),),
                            ),
                            (photoBenef == '')
                                ? Container(
                                width: 150.0,
                                height: 150.0,
                                child: ContianerImage(Image.asset(
                                  'images/no_image.jpg',
                                  fit: BoxFit.fill,
                                ))
                            )
                                : ContianerImage(Image.file(File(photoBenef))),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                IconButton(
                                    icon: Icon(Icons.camera_enhance),
                                    onPressed: (() => getPhoto(ImageSource.camera))),
                                IconButton(
                                    icon: Icon(Icons.photo_library),
                                    onPressed: (() => getPhoto(ImageSource.gallery)))
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              Container(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () =>                                   sendData(
                      context,
                      nomBenef,
                      prenomBenef,
                      passwordBenef,
                      emailBenef,
                      filiereBenef,
                      niveauBenef,
                      dateNaissance,
                      sexe,
                      lieuNaissance,
                      telEtudiant,
                      telParent,
                      File(cni),
                      File(bacBenef),
                      File(photoBenef)),
                  child:
                  Text(
                    (_currentPage != 3)? 'Next >':'Terminer',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildPageIndicator(),
              )
            ],
          )
          // controller: controller,
        ));
  }

  champ(String titre, TypeTextField type, IconData iconn, TextInputType inputType) {
    return Center(
      // Icon(iconn),
      child :SizedBox(
          width: MediaQuery.of(context).size.width - 50,
          // width: 300.0,
          child : Column(
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
                            setState(() {
                              emailBenef = value;
                            });
                            break;
                          case TypeTextField.mdp:
                            setState(() {
                              passwordBenef = value;
                            });
                            break;
                          case TypeTextField.nom:
                            setState(() {
                              nomBenef = value;
                            });
                            break;
                          case TypeTextField.prenom:
                            setState(() {
                              prenomBenef = value;
                            });
                            break;
                          case TypeTextField.filiere:
                            setState(() {
                              filiereBenef = value;
                            });
                            break;
                          case TypeTextField.telParent:
                            setState(() {
                              telParent = value;
                            });
                            break;
                          case TypeTextField.telEtudiant:
                            setState(() {
                              telEtudiant = value;
                            });
                            break;
                          case TypeTextField.niveau:
                            setState(() {
                              niveauBenef = value;
                            });
                            break;
                          case TypeTextField.lieuNaissance:
                            setState(() {
                              lieuNaissance = value;
                            });
                            break;
                        }
                      },
                    )),
              )
            ],
          )),
    );
  }

  Future getPhoto(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    var nouvelleIMage = await _picker.pickImage(source: source);
    setState(() {
      photoBenef = nouvelleIMage!.path;
    });

    // upload(File(photoBenef));

    // // Save and Rename file to A
    //     // String dir = (await getApplicationDocumentsDirectory()).path;
    //     // String newPath = path.join(dir,'photo_'+nomBenef);
    //     // File f = await File(nouvelleIMage.path).copy(newPath);pp directory
    // photoBenef = f.toString();
    // print(photoBenef);
  }

  Future getImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    print(_picker);
    var nouvelleIMage = await _picker.pickImage(source: source);
    print(nouvelleIMage);

    // upload(File(photoBenef));

// Save and Rename file to App directory
    String dir = (await getApplicationDocumentsDirectory()).path;
    String newPath = path.join(dir, 'bac_' + nomBenef);
    File f = await File(nouvelleIMage!.path).copy(newPath);
    print(f);
    setState(() {
      bacBenef = f.path;
    });
  }
  Future getCni(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    print(_picker);
    var nouvelleIMage = await _picker.pickImage(source: source);
    print(nouvelleIMage);

    // upload(File(photoBenef));

// Save and Rename file to App directory
    String dir = (await getApplicationDocumentsDirectory()).path;
    String newPath = path.join(dir, 'cni_' + nomBenef);
    File f = await File(nouvelleIMage!.path).copy(newPath);
    print(f);
    setState(() {
      cni = f.path;
    });
  }
}

padding() {
  return const Padding(padding: EdgeInsets.only(top: 2.0, bottom: 2.0));
}

ContianerImage(Image image) {
  return Container(
      height: 200.0,
      width: 200.0,
      child: Card(
        elevation: 10.0,
        child: image,
      ));
}

void sendData(
    BuildContext context,
    String nom,
    String prenom,
    String password,
    String email,
    String filiere,
    String niveau,
    String date,
    String sexe,
    String lieuDeNaissance,
    String telEtudiant,
    String telParent,
    File cni,
    File bac,
    File imageFile) async {
  // set up POST request arguments
  // final response1 = await http.get(Uri.parse('http://10.0.2.2:8000/api/etudiants'));
  // List etds = jsonDecode(response1.body);
  // print(etds.length);

  print("user :" + nom);
  print("password :" + password);

  late String api = 'http://10.0.2.2:8000/api/etudiants';
  // late String api = 'http://192.168.1.184:8000/api/etudiants';
  // late String api = 'http://192.168.43.130:8000/api/etudiants';

  final url = Uri.parse(api);
  final headers = {"Content-type": "application/json"};
  final json = """{
      "username": "$nom",
      "password": "$password",
      "prenom":"$prenom",
      "photo": "",
      "email": "$email",
      "bacBenef": "",
      "statutBenef": "en cours",
      "filiere":"$filiere",
      "niveau":"$niveau",
      "matricule":"",
      "sexe":"$sexe",
      "dateNaissance":"0/0/0",
      "lieuNaissance":"$lieuDeNaissance",
      "telEtudiant":"$telEtudiant",
      "telParent":"$telParent",
      "cni":""
      }""";
  // make POST request
  final response = await http.post(url, headers: headers, body: json);
  if (imageFile.path != '') {
    upload(imageFile);
  }
  if (bac.path != '') {
    upload(bac);
  }
  if (cni.path != '') {
    upload(cni);
  }

  // check the status code for the result
  final statusCode = response.statusCode;

  // this API passes back the id of the new item added to the body
  final body = response.body;
  print(body);
  Etudiant etd = Etudiant.fromJson(jsonDecode(body));

  if (statusCode == 200 || statusCode == 201) {
    print("envoyer");
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => HomePage(id: etd.id, statut: etd.statut_benef,niveau: etd.niveauBenef,filiere: etd.filiereBenef,)),
    );
  } else {
    print(statusCode);
  }

  // {
  //   "title": "Hello",
  //   "body": "body text",
  //   "userId": 1,
  //   "id": 101
  // }
}

upload(File imageFile) async {
  // open a bytestream
  var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
  // get file length
  var length = await imageFile.length();

  late String api = 'http://10.0.2.2:8000/api';
  // late String api = 'http://192.168.43.130:8000/api';
  // late String api = 'http://192.168.1.184:8000/api';
  // string to uri
  var uri = Uri.parse(api+"/media_objects");

  // create multipart request
  var request = http.MultipartRequest("POST", uri);

  // multipart that takes file
  var multipartFile = http.MultipartFile('file', stream, length,
      filename: path.basename(imageFile.path));

  // add file to multipart
  request.files.add(multipartFile);

  // send
  var response = await request.send();
  // print(response.statusCode);

  // listen for response
  response.stream.transform(utf8.decoder).listen((value) {
    // print(value);
  });
}

enum TypeTextField {
  nom,
  prenom,
  email,
  mdp,
  photo,
  bac,
  filiere,
  niveau,
  matricule,
  sexe,
  dateNaissance,
  lieuNaissance,
  telEtudiant,
  telParent,
  cni
}
