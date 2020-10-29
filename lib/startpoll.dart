import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:test_app/widgets/widgets.dart';
import 'package:http/http.dart' as http;

class StartPollPage extends StatefulWidget {
  String passedValue = "";
  StartPollPage({Key  key, this.passedValue}) : super(key: key);
  @override
  _StartPollPageState createState() => _StartPollPageState(passedValue);
}

class _StartPollPageState extends State<StartPollPage> {
  int _currentStep = 0;
  String passedValue = "";
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
            )
        ),
        child:Container(
            child: Stepper(
              type: StepperType.horizontal,
              steps: _mySteps(),
              currentStep: this._currentStep,
              onStepContinue: (){
                setState(() {
                  if(this._currentStep < this._mySteps().length - 1){
                  this._currentStep = this._currentStep + 1;
                  }else{
                    print('Completed');
                  }
                });
              },
              onStepCancel: (){
                setState(() {
                  if(this._currentStep > 0){
                    this._currentStep = this._currentStep - 1;
                  }else{
                    this._currentStep = 0;
                  }
                });
              },
            ),
          ),
        ),
      );
  }

  List<Step> _mySteps(){
    List<Step> _steps = [
      Step(
        title: Text('Step 1'),
        content:TextField(),
        isActive: _currentStep >= 0,
      ),
      Step(
        title: Text('Step 2'),
        content:TextField(),
        isActive: _currentStep >= 1,
      )
    ];
    return _steps;
  }

  // child: FutureBuilder(
  // future: selectionDetails(),
  // builder: (context, snapshot){
  // if(snapshot.hasError){
  // print(snapshot.error);
  // }
  // return snapshot.hasData ? ListView.builder(
  // itemCount: snapshot.data.length,
  // itemBuilder: (context, index){
  // List list = snapshot.data;
  // return Container(
  // child: Column(
  // children: [
  // Text(list[index]["option_1"],  style:
  // TextStyle(
  // color: Colors.white,
  // fontSize: 20,
  // fontWeight: FontWeight.bold)),
  // Text(list[index]["option_2"],style:
  // TextStyle(
  // color: Colors.white,
  // fontSize: 20,
  // fontWeight: FontWeight.bold)),
  // Text(list[index]["option_3"],style:
  // TextStyle(
  // color: Colors.white,
  // fontSize: 20,
  // fontWeight: FontWeight.bold)),
  // Text(list[index]["option_4"],style:
  // TextStyle(
  // color: Colors.white,
  // fontSize: 20,
  // fontWeight: FontWeight.bold)),
  // ],
  // ),
  // );
  // }): Center(
  // child: CircularProgressIndicator(),
  // );
  // },
  // )
}
