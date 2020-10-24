class Polls{
  String title;
  int age_limitation;


  Polls({this.title, this.age_limitation});


  Polls.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        age_limitation = json['age_limitation'];
}