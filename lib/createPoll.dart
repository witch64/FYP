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
import 'addOption.dart';
import 'database/polls.dart';

class Age{
  int age;

  Age(this.age);

  static List<Age> getAge() {
    return <Age>[
      Age(0),
      Age(10),
      Age(20),
      Age(30),
      Age(40),
      Age(50),
      Age(60),
      Age(70),
      Age(80),
      Age(90),
      Age(100),
    ];
  }
}

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
  List<Age> _age = Age.getAge();
  List<DropdownMenuItem<Age>> _dropdownAge;
  Age _selectedAge;

  TextEditingController titleCTRL = TextEditingController();
  File _image;


  Future getImageGallery() async {
    //var imageFile = await picker.getImage(source: ImageSource.gallery);
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


  List<DropdownMenuItem<Age>> buildDropDownAge(List age){
    List<DropdownMenuItem<Age>> items = List();

    for(Age selectage in age){
      items.add(DropdownMenuItem(value: selectage, child: Text(selectage.age.toString())));
    }
    return items;
  }

  onChangeDropdownItem(Age selectedAge){
    setState((){
      _selectedAge = selectedAge;
    });
  }

  Future createpoll(
      String title,
      int age_limitation,
      File imageFile) async {

    var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.lengthSync();
    var uri = Uri.parse("http://192.168.0.158/fyp_db/createpoll.php");

    var request = new http.MultipartRequest("post", uri);

    var multipartFile = new http.MultipartFile("poll_pic", stream, length,
        filename: basename(imageFile.path));

    request.fields['title'] = titleCTRL.text;
    request.fields['age_limitation'] = _selectedAge.age.toString();

    request.files.add(multipartFile);

    //var response = await http.post(theUrl, body: body);
    var sentStream = await request.send();
    var response = await http.Response.fromStream(sentStream);
    print(response.body.toString());

    if (json.decode(response.body.toString()) == "Success") {
      Fluttertoast.showToast(
          msg: "Please add option.",
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
  void initState(){
    _dropdownAge = buildDropDownAge(_age);
    _selectedAge = _dropdownAge[0].value;

    titleCTRL = TextEditingController();
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
                              ? new Text("No image selected. ",
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
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your title';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: <Widget>[
                      Text("AGE LIMITATION     ",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      DropdownButton(
                        value: _selectedAge,
                        items: _dropdownAge,
                        onChanged: onChangeDropdownItem,
                      ),
                      Text('   Selected: ${_selectedAge.age}'),
                    ],
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
                            if(_image == null){
                              Fluttertoast.showToast(
                                  msg: "Please select an image!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);

                            }else if(_CreatePollsPageForm.currentState.validate()){
                              createpoll(titleCTRL.text, _selectedAge.age, _image);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => AddOptionPage()));

                            }else{
                              Fluttertoast.showToast(
                                  msg: "Please check the error message!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          },
                          child: Center(
                            child: Text(
                              'ADD OPTION',
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



