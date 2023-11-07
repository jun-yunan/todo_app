class UserModel {
  String? uid;
  String? name;
  String? imageUrl;
  String? createdAt;
  String? provider;
  String? email;
  String? bio;
  String? address;
  String? birthday;
  String? phoneNumber;
  bool? isAccountVip;
  String? gender;

  // TypeAccount? acc;

  UserModel({
    this.uid,
    this.name,
    this.imageUrl,
    this.createdAt,
    this.provider,
    this.email,
    this.address,
    this.bio,
    this.birthday,
    this.phoneNumber,
    this.isAccountVip = false,
    this.gender,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json["uid"],
        name: json["name"],
        imageUrl: json["imageUrl"],
        createdAt: json["createdAt"],
        provider: json["provider"],
        email: json["email"],
        address: json["address"],
        bio: json["bio"],
        birthday: json["birthday"],
        phoneNumber: json["phoneNumber"],
        isAccountVip: json["isAccountVip"],
        gender: json["gender"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "imageUrl": imageUrl,
        "createdAt": createdAt,
        "provider": provider,
        "email": email,
        "address": address,
        "bio": bio,
        "birthday": birthday,
        "phoneNumber": phoneNumber,
        "isAccountVip": isAccountVip,
        "gender": gender,
      };
}
