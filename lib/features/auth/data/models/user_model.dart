class UserDetailsModel {
  final String? name;
  final String? email;
  final String? phone;
  final String? photo;
  final String? id;
  final bool? isVerify;
  final bool? isPhoneVerify;
  final String? refarCode; 

  const UserDetailsModel(
      {
      this.isPhoneVerify,
      this.isVerify,
      this.name,
      this.phone,
      this.email,
      this.id,
      this.photo,
      required this.refarCode,
      });

  factory UserDetailsModel.formJson(Map<String, dynamic> json) =>
      UserDetailsModel(
        isVerify: json["isEmailVerification"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        id: json["id"],
        photo: json["photo"],
        isPhoneVerify: json["isPhoneVerification"],
        refarCode: json["refarCode"]
      );
  Map<String, dynamic> toJson() => {
        "isPhoneVerify": isPhoneVerify,
        "isVerify": isVerify,
        "name": name,
        "phone": phone,
        "email": email,
        "id": id,
        "photo": photo,
        "refarCode":refarCode
      };
}
