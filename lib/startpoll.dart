import 'package:flutter/material.dart';
import 'package:test_app/widgets/widgets.dart';

class StartPollPage extends StatefulWidget {
  String verifyLink;
  StartPollPage(this.verifyLink);
  @override
  _StartPollPageState createState() => _StartPollPageState(verifyLink);
}

class _StartPollPageState extends State<StartPollPage> {
  String verifyLink;
  _StartPollPageState(this.verifyLink);

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
    );
  }
}
