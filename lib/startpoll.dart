import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_app/widgets/widgets.dart';
import 'package:http/http.dart' as http;

class StartPollPage extends StatefulWidget {
  String passedValue = "";

  StartPollPage({Key key, this.passedValue}) : super(key: key);

  @override
  _StartPollPageState createState() => _StartPollPageState(passedValue);
}

class _StartPollPageState extends State<StartPollPage> {
  String passedValue = "";
  double option1, option2, option3, option4 = 0;

  _StartPollPageState(this.passedValue);

  Future selectionDetails() async {
    //var theUrl = verifyLink;
    //var response = await http.post(theUrl, body: body);

    var response = await http.get(passedValue);

    //print(verifyLink);

    //print(json.decode(response.body.toString()));
    return json.decode(response.body.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
      ),
      body: Container(
        height: 2000,
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
        )),
        child: Container(
            child: FutureBuilder(
          future: selectionDetails(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
            }
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      List list = snapshot.data;
                      return Container(
                        margin: EdgeInsets.only(
                            left: 10.0, top: 10.0, right: 10.0, bottom: 10.0),
                        child: Column(
                          children: [
                            Card(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  list[index]["title"],
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.teal,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            IntrinsicHeight(
                                child: Column(
                                  children: [
                                    Card(
                                      child: Container(
                                        child: Row(
                                          children: [
                                            Container(
                                              constraints:
                                              BoxConstraints(minHeight: 70),
                                              width: 8,
                                              color: Colors.green,
                                            ),
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  Fluttertoast.showToast(
                                                      msg: "Testing 123 ...",
                                                      toastLength:
                                                      Toast.LENGTH_SHORT,
                                                      gravity: ToastGravity.CENTER,
                                                      timeInSecForIosWeb: 1,
                                                      backgroundColor: Colors.red,
                                                      textColor: Colors.white,
                                                      fontSize: 16.0);
                                                },
                                                child: Container(
                                                  alignment: Alignment.centerLeft,
                                                  padding: EdgeInsets.all(10),
                                                  child: Text(
                                                    list[index]["option_1"],
                                                    maxLines: 5,
                                                    style: TextStyle(fontSize: 22),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    Card(
                                      child: Container(
                                        child: Row(
                                          children: [
                                            Container(
                                              constraints:
                                              BoxConstraints(minHeight: 70),
                                              width: 8,
                                              color: Colors.green,
                                            ),
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  Fluttertoast.showToast(
                                                      msg: "Testing 123 ...",
                                                      toastLength:
                                                      Toast.LENGTH_SHORT,
                                                      gravity: ToastGravity.CENTER,
                                                      timeInSecForIosWeb: 1,
                                                      backgroundColor: Colors.red,
                                                      textColor: Colors.white,
                                                      fontSize: 16.0);
                                                },
                                                child: Container(
                                                  alignment: Alignment.centerLeft,
                                                  padding: EdgeInsets.all(10),
                                                  child: Text(
                                                    list[index]["option_2"],
                                                    maxLines: 5,
                                                    style: TextStyle(fontSize: 22),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    Card(
                                      child: Container(
                                        child: Row(
                                          children: [
                                            Container(
                                              constraints:
                                              BoxConstraints(minHeight: 70),
                                              width: 8,
                                              color: Colors.green,
                                            ),
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  Fluttertoast.showToast(
                                                      msg: "Testing 123 ...",
                                                      toastLength:
                                                      Toast.LENGTH_SHORT,
                                                      gravity: ToastGravity.CENTER,
                                                      timeInSecForIosWeb: 1,
                                                      backgroundColor: Colors.red,
                                                      textColor: Colors.white,
                                                      fontSize: 16.0);
                                                },
                                                child: Container(
                                                  alignment: Alignment.centerLeft,
                                                  padding: EdgeInsets.all(10),
                                                  child: Text(
                                                    list[index]["option_3"],
                                                    maxLines: 5,
                                                    style: TextStyle(fontSize: 22),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    Card(
                                      child: Container(
                                        child: Row(
                                          children: [
                                            Container(
                                              constraints:
                                              BoxConstraints(minHeight: 70),
                                              width: 8,
                                              color: Colors.green,
                                            ),
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  Fluttertoast.showToast(
                                                      msg: "Testing 123 ...",
                                                      toastLength:
                                                      Toast.LENGTH_SHORT,
                                                      gravity: ToastGravity.CENTER,
                                                      timeInSecForIosWeb: 1,
                                                      backgroundColor: Colors.red,
                                                      textColor: Colors.white,
                                                      fontSize: 16.0);
                                                },
                                                child: Container(
                                                  alignment: Alignment.centerLeft,
                                                  padding: EdgeInsets.all(10),
                                                  child: Text(
                                                    list[index]["option_4"],
                                                    maxLines: 5,
                                                    style: TextStyle(fontSize: 22),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 10,),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  )
                : Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.cyanAccent,
                      valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                    ),);
          },
        )),
      ),
    );
  }
}
