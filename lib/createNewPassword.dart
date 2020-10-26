import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import './main.dart';
import './forgotPassword.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class CreateNewPasswordPage extends StatefulWidget {
  String passedValue = "";

  CreateNewPasswordPage({Key  key, this.passedValue}) : super(key: key);
  @override
  _CreateNewPasswordPageState createState() => _CreateNewPasswordPageState(passedValue);
}

class _CreateNewPasswordPageState extends State<CreateNewPasswordPage> {
  String passedValue = "";
  _CreateNewPasswordPageState(this.passedValue);

  final _createNewPasswordForm = GlobalKey<FormState>();
  TextEditingController passwordCTRL = TextEditingController();
  TextEditingController confirm_passwordCTRL = TextEditingController();

  String newPass;
  Future resetPassword() async {
    var theUrl = passedValue;
    var body = {
      "password": passwordCTRL.text,
      "confirm_password": confirm_passwordCTRL.text,
    };

    var response = await http.post(theUrl, body: body);
    setState(() {
      newPass = json.decode(response.body.toString());
    });

    print(json.decode(response.body.toString()));

    if (json.decode(response.body.toString()) == "Current Password") {
      Fluttertoast.showToast(
          msg: "This is Current Password!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "New Password Created! $newPass",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      sendMail();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }

  sendMail() async{
    String username = 'developertest1245@gmail.com';
    String password = 'Zen1220!';
    //also use for gmail smtp
    //final smtpServer = gmail(username, password);

    //user for your own domain
    // ignore: deprecated_member_use
    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'Me')
      ..recipients.add('chnkaixin@gmail.com')
    //..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
    //..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject = 'Dart Mailer library :: 😀 :: ${DateTime.now()}'
      ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html = "<h1>Hi, </h1>\n<p>Your new password is </p>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Please Enter Valid Email';
    else
      return null;
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _createNewPasswordForm,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: ListView(
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                    child: Text(
                      'Create New',
                      style: TextStyle(
                          fontSize: 50.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 170.0, 0.0, 0.0),
                    child: Text(
                      'Password',
                      style: TextStyle(
                          fontSize: 50.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: passwordCTRL,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      labelText: 'PASSWORD',
                      labelStyle: TextStyle(
                          color: Colors.grey,
                        fontWeight: FontWeight.bold, ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.indigoAccent)
                      ),
                    ),
                    obscureText: true,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter password';
                      }else if(value.length < 6){
                        return 'Password must be more than 6 digit';
                      }else if(value.length > 12){
                        return 'Password must not more than 12 digit';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    controller: confirm_passwordCTRL,
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
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter confirm password';
                      }else if(value != passwordCTRL.text){
                        return "Incorrect Password";
                      }else if(value.length < 6){
                        return 'Password must be more than 6 digit';
                      }else if(value.length > 12){
                        return 'Password must not more than 12 digit';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.0),
                  Container(
                      height: 50.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(30.0),
                        shadowColor: Colors.indigo,
                        color: Colors.indigoAccent,
                        elevation: 7.0,
                        child: GestureDetector(
                          onTap: () {
                            if(_createNewPasswordForm.currentState.validate()){
                                  resetPassword();
                            }
                          },
                          child: Center(
                            child: Text(
                              'RESET PASSWORD',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'),
                            ),
                          ),
                        ),
                      )),
                  SizedBox(height: 20.0),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
