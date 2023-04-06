class User {
  int id;
  String firstName;
  String lastName;
  DateTime birthDate;
  Gender gender;
  String? about;
  String? image;
  bool verified = false;
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
    this.id = 0,
    this.about,
    this.image,
    this.sid,
  }) {
    id += id;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['firstName'] ?? "",
      lastName: json['lastName'] ?? "",
      birthDate: json['birthDate'] ?? DateTime.now(),
      // gender: json['gender'] ?? Gender,
      email: json['email'] ?? "",
      password: json['password'] ?? "",
      id: json['id'] ?? "",
      about: json['about'] ?? "",
      image: json['image'] ?? "",
      sid: json['sid'] ?? 0,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "birthDate": birthDate,
      "gender": gender,
      "email": email,
      "password": password,
      "about": about,
      "image": image,
      "sid": sid,
      "id": id.toString(),
    };
  }
}

enum Gender { female, male }

enum AccessRole { admin, attendee, organizer }
