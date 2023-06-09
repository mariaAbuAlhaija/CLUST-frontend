class User {
  int id;
  String firstName;
  String lastName;
  String birthDate;
  Gender gender;
  String about = " ";
  String image = " ";
  var verified;
  AccessRole? accessRole;
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
    this.about = " ",
    this.image = " ",
    this.sid,
    this.verified,
    this.accessRole,
  }) {
    verified = 0;
  }

  factory User.fromJson(json) {
    User _user = User(
        json['first_name'] ?? "",
        json['last_name'] ?? "",
        json['birth_date'] ?? DateTime.now().toString(),
        // gender: json['gender'] ?? Gender.,
        json['email'] ?? "",
        json['password'] ?? "",
        json['id'] ?? 0,
        about: json['about'] ?? "",
        image: json['image'] ?? "",
        sid: json['SID'] ?? 0,
        accessRole: json["access_role"] == "organizer"
            ? AccessRole.organizer
            : json["access_role"] == "pending"
                ? AccessRole.pending
                : AccessRole.attendee);
    _user.verified = json['verified'];
    return _user;
  }

  factory User.fromObj(User user,
      {firstName,
      lastName,
      birthDate,
      gender,
      email,
      password,
      id,
      about,
      image,
      sid,
      verified,
      accessRole}) {
    print("${accessRole} to obj");
    User _user = User(
      firstName ?? user.firstName,
      lastName ?? user.lastName,
      birthDate ?? user.birthDate,
      email ?? user.email,
      password ?? user.password,
      id ?? user.id,
      gender: gender ?? user.gender,
      about: about ?? user.about,
      image: image ?? user.image,
      sid: sid ?? user.sid,
      verified: verified ?? user.verified,
      accessRole: accessRole,
    );
    print("${_user.accessRole} obj");
    return _user;
  }

  Map<String, dynamic> toJson() {
    // print(accessRole.name);
    print(accessRole!.name);
    print(accessRole!.name.toString());
    print(accessRole!.name.runtimeType);
    return {
      "first_name": firstName,
      "last_name": lastName,
      "birth_date": birthDate,
      "gender": gender.name,
      "email": email,
      "password": password,
      "SID": sid.toString(),
      "verified": "0",
      "access_role": accessRole!.name,
      "id": id.toString(),
      "about": " $about",
      "image": " $image",
    };
  }
}

enum Gender { female, male, other }

enum AccessRole { admin, pending, attendee, organizer }
