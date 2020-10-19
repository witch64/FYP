import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:test_app/register.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/register' : (BuildContext context) => new Register()
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

  //getMethod() async {
  //  String theUrl = 'http://localhost/fyp_db/getData.php';
  //  var res = await http.get(Url.encodeFull(theUrl), headers: {"Accept" : "application/json"});
  //  var responBody = json.decode(res.body);
  //  print(responBody);
//
  //  return responBody;
  //}

  TextEditingController usernameCTRL, passwordCTRL;

  void initState(){
    super.initState();

    usernameCTRL = new TextEditingController();
    passwordCTRL = new TextEditingController();
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
            padding: EdgeInsets.only(top:35.0, left:20.0, right : 20.0),
            child: Column(
              children: <Widget>[
                TextField(
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
                ),
                SizedBox(height: 20.0),
                TextField(
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
                  obscureText: true,
                ),
                SizedBox(height: 5.0),
                Container(
                  alignment: Alignment(1.0, 0.0),
                  padding: EdgeInsets.only(top:15.0, left:20.0),
                  child: InkWell(
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
                      onTap: () {},
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
    );
  }
}
