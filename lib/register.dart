import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:image/image.dart' as Img;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/database/voter_profile.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:math' as Math;
import 'package:async/async.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  Future<Voter_Profile> _futureVoter_Profile;
  TextEditingController voterIdCTRL,
      usernameCTRL,
      nameCTRL,
      passwordCTRL,
      confirm_passCTRL,
      emailCTRL,
      ageCTRL,
      phone_numCTRL;
  String status = '';
  Future<File> file;
  File _image;

  Future getImageGallery() async {
    var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);

    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    int rand = new Math.Random().nextInt(100000);

    Img.Image image = Img.decodeImage(imageFile.readAsBytesSync());
    Img.Image smallerImg = Img.copyResize(image, width: 500, height: 500);

    var compressImg = new File("$path/image_$rand.jpg")
      ..writeAsBytesSync(Img.encodeJpg(smallerImg, quality: 85));
    setState(() {
      _image = compressImg;
    });
  }

  Future upload(File imageFile) async {}

  Future<Voter_Profile> registerUser(
      String voter_id,
      String username,
      String name,
      String password,
      String confirm_pass,
      String email,
      int age,
      int phone_number,
      File imageFile) async {
    var theUrl = 'http://192.168.0.158/fyp_db/register.php';

    var body = json.encode(<String, String>{
      "voter_id": voterIdCTRL.text,
      "username": usernameCTRL.text,
      "name": nameCTRL.text,
      "password": passwordCTRL.text,
      "confirm_password": confirm_passCTRL.text,
      "email": emailCTRL.text,
      "age": ageCTRL.text,
      "phone_number": phone_numCTRL.text,
    });

    var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse("http://192.168.0.158/fyp_db/register.php");

    var request = new http.MultipartRequest("post", uri);

    var multipartFile = new http.MultipartFile("profile_pic", stream, length,
        filename: basename(imageFile.path));

    request.fields['username'] = usernameCTRL.text;
    request.fields['name'] = nameCTRL.text;
    request.fields['password'] = passwordCTRL.text;
    request.fields['confirm_password'] = confirm_passCTRL.text;
    request.fields['email'] = emailCTRL.text;
    request.fields['age'] = ageCTRL.text;
    request.fields['phone_number'] = phone_numCTRL.text;

    request.files.add(multipartFile);

    //var response = await http.post(theUrl, body: body);
    var sentStream = await request.send();
    var response = await http.Response.fromStream(sentStream);
    print(response.body.toString());

    if (response.statusCode == 200) {
      print("Upload Successfully!");
    } else {
      print("Upload Failed!");
    }

    if (json.decode(response.body.toString()) == "Account already exists!") {
      Fluttertoast.showToast(
          msg: "Email Exists. Please try again!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (json.decode(response.body.toString()) == "Success") {
      Fluttertoast.showToast(
          msg: "Register Successful!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Error, Please try again!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  void initState() {
    super.initState();

    voterIdCTRL = new TextEditingController();
    usernameCTRL = new TextEditingController();
    nameCTRL = new TextEditingController();
    passwordCTRL = new TextEditingController();
    confirm_passCTRL = new TextEditingController();
    emailCTRL = new TextEditingController();
    ageCTRL = new TextEditingController();
    phone_numCTRL = new TextEditingController();

    registerUser(
        voterIdCTRL.text,
        usernameCTRL.text,
        nameCTRL.text,
        passwordCTRL.text,
        confirm_passCTRL.text,
        emailCTRL.text,
        int.parse(ageCTRL.text, onError: (source) => -1),
        int.parse(phone_numCTRL.text, onError: (source) => -1),
        _image);
  }

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            padding: EdgeInsets.all(15),
            children: <Widget>[
              Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                      child: Text(
                        'Create An',
                        style: TextStyle(
                            fontSize: 50.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 170.0, 0.0, 0.0),
                      child: Text(
                        'New Account',
                        style: TextStyle(
                            fontSize: 50.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(315.0, 170.0, 0.0, 0.0),
                      child: Text(
                        '.',
                        style: TextStyle(
                            fontSize: 50.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigoAccent),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                  height: 1200,
                  padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                  child: Column(
                    children: <Widget>[
                      Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Center(
                              child: _image == null
                                  ? new Text("No image selected. ")
                                  : new Image.file(_image),
                            ),
                            OutlineButton(
                              onPressed: getImageGallery,
                              child: Text('Choose Image'),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.0),
                      TextField(
                        controller: usernameCTRL,
                        decoration: InputDecoration(
                            hintText: 'Username',
                            labelText: 'USERNAME',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.indigoAccent))),
                      ),
                      SizedBox(height: 10.0),
                      TextField(
                        controller: nameCTRL,
                        decoration: InputDecoration(
                            hintText: 'Name',
                            labelText: 'NAME',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.indigoAccent))),
                      ),
                      SizedBox(height: 10.0),
                      TextField(
                        controller: passwordCTRL,
                        decoration: InputDecoration(
                            hintText: 'Password',
                            labelText: 'PASSWORD',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.indigoAccent))),
                        obscureText: true,
                      ),
                      SizedBox(height: 10.0),
                      TextField(
                        controller: confirm_passCTRL,
                        decoration: InputDecoration(
                            hintText: 'Confirm Password',
                            labelText: 'CONFIRM PASSWORD ',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.indigoAccent))),
                        obscureText: true,
                      ),
                      SizedBox(height: 10.0),
                      TextField(
                        controller: emailCTRL,
                        decoration: InputDecoration(
                            hintText: 'Email',
                            labelText: 'EMAIL',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.indigoAccent))),
                      ),
                      SizedBox(height: 10.0),
                      TextField(
                        controller: ageCTRL,
                        decoration: InputDecoration(
                            hintText: 'Age',
                            labelText: 'AGE',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.indigoAccent))),
                      ),
                      SizedBox(height: 10.0),
                      TextField(
                        controller: phone_numCTRL,
                        decoration: InputDecoration(
                            hintText: 'Phone Number',
                            labelText: 'PHONE NUMBER',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.indigoAccent))),
                      ),
                      SizedBox(height: 50.0),
                      Container(
                          height: 50.0,
                          child: Material(
                            borderRadius: BorderRadius.circular(30.0),
                            shadowColor: Colors.indigo,
                            color: Colors.indigoAccent,
                            elevation: 7.0,
                            child: GestureDetector(
                              onTap: () {
                                registerUser(
                                    voterIdCTRL.text,
                                    usernameCTRL.text,
                                    nameCTRL.text,
                                    passwordCTRL.text,
                                    confirm_passCTRL.text,
                                    emailCTRL.text,
                                    int.parse(ageCTRL.text,
                                        onError: (source) => -1),
                                    int.parse(phone_numCTRL.text,
                                        onError: (source) => -1),
                                    _image);

                                // upload(_image);
                              },
                              child: Center(
                                child: Text(
                                  'REGISTER',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat'),
                                ),
                              ),
                            ),
                          )),
                      SizedBox(height: 20.0),
                      Container(
                        height: 50.0,
                        color: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                  width: 1.0),
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(30.0)),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Center(
                              child: Text('Go Back',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat')),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30.0),
                    ],
                  )),
            ]));
  }
}
