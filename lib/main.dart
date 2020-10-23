import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:test_app/hompage.dart';
import 'package:test_app/register.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import './forgotPassword.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/register' : (BuildContext context) => new Register(),
        '/forgotPassword' : (BuildContext context) => new ForgotPasswordPage(),
      },
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController usernameCTRL = TextEditingController();
  TextEditingController passwordCTRL = TextEditingController();

  Future userLogin() async{
  var theUrl = "http://192.168.0.158/fyp_db/login.php";
  var data = {
    "username": usernameCTRL.text,
    "password": passwordCTRL.text,
  };

  var response = await http.post(theUrl, body: data);

  print(json.decode(response.body.toString()));

  if(json.decode(response.body.toString()) == "Account does not exist!"){
    Fluttertoast.showToast(
          msg: "Please create an account!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }else if((json.decode(response.body.toString()) == "False")){
    Fluttertoast.showToast(
        msg: "Incorrect Password!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }else{
    Fluttertoast.showToast(
        msg: "Login Successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
  }
  }

  @override
  Widget build(BuildContext context) {
    final _loginForm = GlobalKey<FormState>();

    return new Form(
      key: _loginForm,
      //resizeToAvoidBottomPadding: false,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: ListView(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                    child: Text(
                      'Hello',
                      style: TextStyle(
                          fontSize: 80.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 175.0, 0.0, 0.0),
                    child: Text(
                      'There',
                      style: TextStyle(
                          fontSize: 80.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(220.0, 175.0, 0.0, 0.0),
                    child: Text(
                      '.',
                      style: TextStyle(
                        fontSize: 80.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigoAccent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 500,
              padding: EdgeInsets.only(top:35.0, left:20.0, right : 20.0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: usernameCTRL,
                    decoration: InputDecoration(
                      labelText: 'USERNAME',
                      labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.indigoAccent),
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter username';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                   controller: passwordCTRL,
                    decoration: InputDecoration(
                      labelText: 'PASSWORD',
                      labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.indigoAccent),
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    },
                    obscureText: true,
                  ),
                  SizedBox(height: 5.0),
                  Container(
                    alignment: Alignment(1.0, 0.0),
                    padding: EdgeInsets.only(top:15.0, left:20.0),
                    child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed('/forgotPassword');
                        },
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(
                            color: Colors.indigoAccent,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        )
                    ),
                  ),
                  SizedBox(height: 40.0),
                  Container(
                    height: 50.0,
                    child: Material(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.indigoAccent,
                      shadowColor: Colors.indigo,
                      elevation: 7.0,
                      child: GestureDetector(
                        onTap: () {
                          if(_loginForm.currentState.validate()){
                            userLogin();
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
                            'LOGIN',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'New User ? ',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      SizedBox(height: 20.0),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed('/register');
                        },
                        child: Text('Register',
                          style: TextStyle(
                            color: Colors.indigoAccent,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      )
                    ],
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
