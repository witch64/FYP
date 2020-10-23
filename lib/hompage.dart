import 'package:flutter/material.dart';
import 'package:test_app/widgets/widgets.dart';

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
  final _HomePageForm = GlobalKey<FormState>();
  TextEditingController titleCTRL = TextEditingController();
  TextEditingController descCTRL = TextEditingController();

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
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}



