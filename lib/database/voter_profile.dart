class Voter_Profile{
  String username;
  String name;
  String password;
  String confirm_pass;
  String email;
  int age;
  int phoneNum;

  Voter_Profile({this.username, this.name, this.password,
    this.confirm_pass, this.email, this.age, this.phoneNum});


  Voter_Profile.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        password = json['password'],
        confirm_pass = json['confirm_password'],
        email = json["email"],
        age = json["age"],
        name = json["name"],
        phoneNum = json["phone_number"];
}