class ProfileModel {
  String? profileId;
  String? bio;
  String? createdAt;
  String? address;
  String? birthday;
  String? avatar;
  String? phoneNumber;
  String? uid;

  ProfileModel({
    this.profileId,
    this.bio,
    this.createdAt,
    this.address,
    this.birthday,
    this.avatar,
    this.phoneNumber,
    this.uid,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        profileId: json["profileId"],
        bio: json["bio"],
        createdAt: json["createdAt"],
        address: json["address"],
        birthday: json["birthday"],
        avatar: json["avatar"],
        phoneNumber: json["phoneNumber"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "profileId": profileId,
        "bio": bio,
        "createdAt": createdAt,
        "address": address,
        "birthday": birthday,
        "avatar": avatar,
        "phoneNumber": phoneNumber,
        "uid": uid,
      };
}
