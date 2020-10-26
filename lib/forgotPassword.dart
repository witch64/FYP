import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:mailer/smtp_server/mailgun.dart';

import 'createNewPassword.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  final _forgotPasswordForm = GlobalKey<FormState>();
  TextEditingController emailCTRL = new TextEditingController();
  String verifyLink;

  Future checkUser() async {
    var response =
    await http.post('http://192.168.0.158/fyp_db/verify.php', body: {
      "email": emailCTRL.text,
    });

    print(json.decode(response.body.toString()));

    if (json.decode(response.body.toString()) == "INVALID USER") {
      Fluttertoast.showToast(
          msg: "Invalid Email. Please try again!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      setState(() {
        verifyLink = json.decode(response.body.toString());

      });

      Fluttertoast.showToast(
          msg: "Success. Please create new password.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);

      Navigator.push(context, MaterialPageRoute(builder: (context) => new CreateNewPasswordPage(passedValue: verifyLink)));
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
      key: _forgotPasswordForm,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: ListView(
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                    child: Text(
                      'Forgot',
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
                    controller: emailCTRL,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      labelText: 'Email',
                      labelStyle: TextStyle(
                          color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.indigoAccent)
                      ),
                    ),
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter email';
                      }else if(value.isNotEmpty){
                        validateEmail(value);
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
                            if(_forgotPasswordForm.currentState.validate()){
                                checkUser();
                            }

                          },
                          child: Center(
                            child: Text(
                              'VERIFY EMAIL',
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
              ),
            )
          ],
        ),
      ),

    );
  }
}
