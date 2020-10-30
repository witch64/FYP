class Polls{
  String title;
  int age_limitation;
  int selection_id;

  Polls({this.title, this.age_limitation, this.selection_id});


  Polls.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        age_limitation = json['age_limitation'],
        selection_id = json['selection_id'];
}