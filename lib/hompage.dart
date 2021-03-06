import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_app/startpoll.dart';
import 'package:test_app/widgets/widgets.dart';
import 'package:http/http.dart' as http;

import 'createPoll.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _homepageForm = GlobalKey<FormState>();
  String verifyLink;
  String selectionId;

  TextEditingController titleCTRL = TextEditingController();
  TextEditingController descCTRL = TextEditingController();

  Future pollDetails() async{
      var theUrl = "http://192.168.0.158/fyp_db/viewImage.php";

      //var response = await http.post(theUrl, body: body);
      var response = await http.get(theUrl);

      //print( json.decode(response.body.toString()));
      return json.decode(response.body.toString());
  }

  Future nextPage(String selectionId) async {
    var theUrl = "http://192.168.0.158/fyp_db/viewpoll.php";
    var data = {
      "selection_id": selectionId,
    };

    var response = await http.post(theUrl, body: data);
    //print(response.body.toString());

    if (json.decode(response.body.toString()) == "INVALID POLL") {
      Fluttertoast.showToast(
          msg: "Invalid Email. Please try again!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }else{
      setState(() {
        verifyLink = json.decode(response.body.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Form(
      key: _homepageForm,
      child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
      ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => CreatePollsPage()));
          },
          child: Icon(Icons.add),
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Colors.indigo,
                    Colors.indigoAccent,
                    Colors.deepPurpleAccent,
                    Colors.purple,
                  ],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              )
          ),
          child: ListView(
            children: [
              Container(
                child: Column(
                  children: [
                GestureDetector(
                  onTap:(){
                    nextPage(selectionId);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => StartPollPage(passedValue: verifyLink)));
                  },
                  child: Container(
                    height: 2000,
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  child: FutureBuilder(
                  future: pollDetails(),
                  builder: (context, snapshot){
                    if(snapshot.hasError){
                      print(snapshot.error);
                    }
                    return snapshot.hasData ? ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index){
                          List list = snapshot.data;
                          selectionId = list[index]['selection_id'];
                          return Container(
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: 15),
                                    height: 200,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            'http://192.168.0.158/fyp_db/uploads/${list[index]['poll_pic']}',), fit: BoxFit.cover,
                                        )
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.black26,
                                  ),
                                  alignment: Alignment.center,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(list[index]['title'],
                                          style:
                                          TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            shadows: <Shadow>[
                                              Shadow(
                                                offset: Offset(3.0, 4.0),
                                                blurRadius: 10.0,
                                                color: Colors.black,
                                              ),
                                            ]
                                          ),),
                                     ],
                                    ),
                                )
                              ],
                            ),
                          );
                        })
                        : Center(
                      child: CircularProgressIndicator(),
                    );
                  },
              ),
        ),
                )],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}



