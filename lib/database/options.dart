class Options{
  String option1;
  String option2;
  String option3;
  String option4;



  Options({this.option1, this.option2, this.option3, this.option4});


  Options.fromJson(Map<String, dynamic> json)
      : option1 = json['option_1'],
        option2 = json['option_2'],
        option3 = json['option_3'],
        option4 = json['option_4'];
}