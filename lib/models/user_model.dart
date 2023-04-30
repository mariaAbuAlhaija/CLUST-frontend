class User {
  int? id;
  String firstName;
  String lastName;
  String birthDate;
  Gender gender;
  String? about;
  String? image;
  var verified;
  AccessRole accessRole = AccessRole.attendee;
  int? sid;
  String email;
  String password;
  User({
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    this.gender = Gender.female,
    required this.email,
    required this.password,
    this.about,
    this.image,
    this.sid,
    this.id,
  }) {
    accessRole = AccessRole.attendee;
    verified = 0;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    User _user = User(
        firstName: json['firstName'] ?? "",
        lastName: json['lastName'] ?? "",
        birthDate: json['birthDate'] ?? DateTime.now().toString(),
        // gender: json['gender'] ?? Gender.,
        email: json['email'] ?? "",
        password: json['password'] ?? "",
        about: json['about'] ?? "",
        image: json['image'] ?? "",
        sid: json['sid'] ?? 0,
        id: json['id'] ?? 0);
    _user.verified = json['verified'];
    return _user;
  }
  Map<String, dynamic> toJson() {
    // print(accessRole.name);
    print(verified);
    print(verified.toString());
    print(verified.runtimeType);
    return {
      "first_name": firstName,
      "Last_name": lastName,
      "birth_date": birthDate,
      "gender": gender.name,
      "email": email,
      "password": password,
      "about": about ?? "",
      "image": image ?? "",
      "sid": sid ?? "",
      "verified": "0",
      "access_role": accessRole.name,
      "id": id.toString(),
    };
  }
}

enum Gender { female, male, other }

enum AccessRole { admin, attendee, organizer }
