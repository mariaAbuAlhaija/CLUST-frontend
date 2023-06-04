class User {
  int id;
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
  User(
    this.firstName,
    this.lastName,
    this.birthDate,
    this.email,
    this.password,
    this.id, {
    this.gender = Gender.female,
    this.about,
    this.image,
    this.sid,
  }) {
    accessRole = AccessRole.attendee;
    verified = 0;
  }

  factory User.fromJson(json) {
    User _user = User(
      json['first_name'] ?? "",
      json['last_name'] ?? "",
      json['birth_date'] ?? DateTime.now().toString(),
      // gender: json['gender'] ?? Gender.,
      json['email'] ?? "",
      json['password'] ?? "", json['id'] ?? 0,
      about: json['about'] ?? "",
      image: json['image'] ?? "",
      sid: json['sid'] ?? 0,
    );
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
      "last_name": lastName,
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
