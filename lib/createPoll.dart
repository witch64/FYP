import 'package:flutter/material.dart';
import 'package:test_app/widgets/widgets.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:image/image.dart' as Img;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:math' as Math;
import 'package:async/async.dart';
import 'package:email_validator/email_validator.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class CreatePollsPage extends StatefulWidget {
  @override
  _CreatePollsPageState createState() => _CreatePollsPageState();
}

class _CreatePollsPageState extends State<CreatePollsPage> {
  final _CreatePollsPageForm = GlobalKey<FormState>();
  TextEditingController titleCTRL = TextEditingController();
  TextEditingController descCTRL = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return new Form(
      key: _CreatePollsPageForm,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: appBar(context),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          brightness: Brightness.light,
        ),
        body: ListView(
          children: <Widget>[
            Container(
              height: 1500,
              padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Center(
                          child: _image == null
                              ? new Text("No image selected. (Optional)",
                            style: TextStyle(
                              fontSize: 20,
                            ),)
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
                  TextFormField(
                    controller: titleCTRL,
                    decoration: InputDecoration(
                      hintText: 'Poll Title',
                      labelText: 'Poll Title',
                      labelStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,),
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.indigoAccent)
                      ),
                    ),

                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    controller: descCTRL,
                    decoration: InputDecoration(
                      hintText: 'Poll Description',
                      labelText: 'Poll Description',
                      labelStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,),
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.indigoAccent)
                      ),
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Container(
                      height: 50.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(30.0),
                        shadowColor: Colors.indigo,
                        color: Colors.indigoAccent,
                        elevation: 7.0,
                        child: GestureDetector(
                          onTap: () {

                          },
                          child: Center(
                            child: Text(
                              'CREATE POLL',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'),
                            ),
                          ),
                        ),
                      )),
                ],

              ),
            ),
          ],
        ),
      ),
    );
  }
}



