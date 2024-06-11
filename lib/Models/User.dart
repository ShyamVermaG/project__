class User{
  String _id="nothing";
  String _name="nothing";
  String _email="nothing";
  String _phone="nothing";
  String _website="nothing";


  User(this._id, this._name, this._email, this._phone,this._website);

  // to convert from json to obj
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
       json["id"].toString(),
       json['name'],
       json['email'],
       json['phone'],
       json['website'],
    );
  }

  String get website => _website;

  set website(String value) {
    _website = value;
  }

  String get phone => _phone;

  set phone(String value) {
    _phone = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }
}