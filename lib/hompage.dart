import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image/image.dart';
import 'package:test_app/widgets/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;

import 'createPoll.dart';

class PollTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _HomePageForm = GlobalKey<FormState>();
  TextEditingController titleCTRL = TextEditingController();
  TextEditingController descCTRL = TextEditingController();

  Future pollDetails() async{
      var theUrl = "http://192.168.0.158/fyp_db/view.php";
      var response = await http.get(theUrl);

      return json.decode(response.body.toString());
  }

  @override
  Widget build(BuildContext context) {
    return new Form(
      key: _HomePageForm,
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
                Container(
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
                        return Container(
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  height: 150,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          'http://192.168.0.158/fyp_db/uploads/${list[index]['poll_pic']}',), fit: BoxFit.cover,
                                      )
                                  ),
                                ),
                              ),
                              Container(
                                height: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.black12,
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
                                              offset: Offset(3.0, 3.0),
                                              blurRadius: 5.0,
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



