class RegisterModel {

  int? id;
  final String firstname;
  final String lastname;
  final String ProfileImage;
  final String email;
  final String phonenumber;
  final String password;
  final String confirmpassword;
  final String key;

  RegisterModel(
      {
      this.id,
      required this.firstname,
      required this.lastname,
      required this.ProfileImage,
      required this.email,
      required this.phonenumber,
      required this.password,
      required this.confirmpassword,
      required this.key});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
      'ProfileImage': ProfileImage,
      'email': email,
      'phonenumber': phonenumber,
      'password': password,
      'confirmpassword': confirmpassword,
      'key': key
    };
  }

  factory RegisterModel.fromMap(Map<String, dynamic> map) {
    return RegisterModel(
        id: map['id'],
        firstname: map['firstname'],
        lastname: map['lastname'],
        ProfileImage: map['ProfileImage'],
        email: map['email'],
        phonenumber: map['phonenumber'],
        password: map['password'],
        confirmpassword: map['confirmpassword'],
        key: map['key']);
  }
}
