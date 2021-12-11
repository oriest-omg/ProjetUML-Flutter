import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:async/async.dart';
import 'package:path_provider/path_provider.dart';
import 'package:porjet_uml/model/etudiant.dart';


import 'home_page.dart';



class InscriptionPage extends StatefulWidget {
  const InscriptionPage({Key? key}) : super(key: key);

  @override
  _InscriptionPageState createState() => _InscriptionPageState();
}

class _InscriptionPageState extends State<InscriptionPage> {

  late String nomBenef = '';
  late String emailBenef ='';
  late String passwordBenef = '';
  late String photoBenef = '';
  late String bacBenef = '';
  late String statutBenef = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: SizedBox(child: Text("Inscription"),)),
      body: SingleChildScrollView(
        child : Container(
          child: Column(
            children: [
              padding(),
              champ("Nom :", TypeTextField.nom,Icons.eleven_mp),
              padding(),
              // champ("Prenom :", TypeTextField.email,Icons.eleven_mp),
              // padding(),
              // champ("Sexe :", TypeTextField.email,Icons.eleven_mp),
              // padding(),
              // champ("Date de naissance :", TypeTextField.email,Icons.eleven_mp),
              // padding(),
              // champ("Lieu de naissance :", TypeTextField.email,Icons.eleven_mp),
              padding(),
              champ("Email :", TypeTextField.email,Icons.eleven_mp),
              padding(),
              // champ("Telephone-Etudiant :", TypeTextField.email,Icons.eleven_mp),
              // padding(),
              // champ("Telephone-Parent :", TypeTextField.email,Icons.eleven_mp),
              // Text("Ecole"),
              // padding(),
              // champ("Diplome obtenu :", TypeTextField.email,Icons.eleven_mp),
              // padding(),
              // champ("Filière souhaité :", TypeTextField.email,Icons.eleven_mp),
              // padding(),
              // champ("CNI :", TypeTextField.email,Icons.eleven_mp),
              // padding(),
              SizedBox(

                child:Row(
                  children: [
                    Text('Bac :'),
                    IconButton(icon: Icon(Icons.photo_library), onPressed: (() => getImage(ImageSource.gallery))),
                  ],
                )
              ),
              champ("mot de passe :", TypeTextField.mdp,Icons.eleven_mp),
              padding(),
              (photoBenef == '')
                  ? ContianerImage(Image.asset('images/no_image.jpg',fit: BoxFit.fill,))
                  : ContianerImage(Image.file( File(photoBenef))),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(icon: Icon(Icons.camera_enhance), onPressed: (() => getPhoto(ImageSource.camera))),
                  IconButton(icon: Icon(Icons.photo_library), onPressed: (() => getPhoto(ImageSource.gallery)))
                ],
              ),
              TextButton(onPressed: ()=>{  sendData(context,emailBenef,passwordBenef,nomBenef,photoBenef,File(photoBenef)), print("pass"+passwordBenef) }, child: new Text('Valider', style: new TextStyle(color: Colors.green,fontSize:20.0 ),))
            ],
          ),
        ),
      )
    );
  }
  champ(String titre,TypeTextField type, IconData iconn){
    return Row(children: [
      Icon(iconn),
      SizedBox(
        // width:  MediaQuery.of(context).size.width-50,
        width:  150.0,
        child: Form(
            child: TextField(
              style: const TextStyle(fontSize: 20.0,),
              decoration:  InputDecoration(
                labelText: titre,
              ),
              onChanged: (value) async {
                    switch (type) {
                    case TypeTextField.email:
                      emailBenef = value;
                      break;
                    case TypeTextField.mdp:
                      passwordBenef = value;
                      break;
                      case TypeTextField.nom:
                        nomBenef = value;
                        break;
                    }
              },
              // validator: (String? value) {
              //   if (value == null || value.isEmpty) {
              //     return 'Please enter some text';
              //   }
              //   return null;
              // },
            )),
      ),
    ]);
  }
  Future getPhoto(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    var nouvelleIMage = await _picker.pickImage(source: source);
    photoBenef = nouvelleIMage!.path;
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
    bacBenef = nouvelleIMage!.path;
    // upload(File(photoBenef));

// Save and Rename file to App directory
    String dir = (await getApplicationDocumentsDirectory()).path;
    String newPath = path.join(dir,'bac_'+nomBenef);
    File f = await File(nouvelleIMage.path).copy(newPath);
    print(f);

  }
}
padding() {
  return const Padding(padding: EdgeInsets.only(top: 10.0, bottom: 10.0));
}
ContianerImage(Image image)
{
  return Container(
      height: 200.0,
      width: 200.0,
      child : Card(
        elevation: 10.0,
        child : image,
      )
  );
}
void sendData(
    BuildContext context,
    String username,
    String password,
    String email,
    String photo,
    File imageFile) async {
  // set up POST request arguments
  // final response1 = await http.get(Uri.parse('http://10.0.2.2:8000/api/etudiants'));
  // List etds = jsonDecode(response1.body);
  // print(etds.length);

  print("user :"+username);
  print("password :"+password);
  print("photo:"+photo);

  final url = Uri.parse("http://10.0.2.2:8000/api/etudiants");
  final headers = {"Content-type": "application/json"};
  final json = """{
      "username": "$username",
      "password": "$password",
      "photo": "$photo",
      "email": "$email",
      "bacBenef": "",
      "statutBenef": "en cours"
      }""";
  // make POST request
  final response = await http.post(url, headers: headers, body: json);
  upload(imageFile);

  // check the status code for the result
  final statusCode = response.statusCode;

  // this API passes back the id of the new item added to the body
  final body = response.body;
  print(body);
  Etudiant etd = Etudiant.fromJson(jsonDecode(body));


  if(statusCode == 200 || statusCode == 201)
    {

      final response1 = await http.get(Uri.parse('http://10.0.2.2:8000/api/etudiants/'));

      print("envoyer");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage( id: etd.id,statut: etd.statut_benef)),
      );
    }else
      {
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

  // string to uri
  var uri = Uri.parse("http://10.0.2.2:8000/api/media_objects");

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

enum TypeTextField {nom,email, mdp,bac}