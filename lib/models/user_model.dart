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
  User(
    this.id,
    this.firstName,
    this.lastName,
    this.birthDate,
    this.gender,
    this.email,
    this.password, {
    this.about,
    this.image,
    this.sid,
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['id'] ?? "",
      json['firstName'] ?? "",
      json['lastName'] ?? "",
      json['birthDate'] ?? 0,
      json['gender'] ?? 0,
      json['email'] ?? "",
      json['password'],
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
