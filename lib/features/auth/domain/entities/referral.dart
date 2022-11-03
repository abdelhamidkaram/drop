class Referral {
  final String? code;
  final int? numberOfUsed;
  final String? userId;
  Referral({this.code, this.numberOfUsed, this.userId});

  factory Referral.formJson(Map<String, dynamic> json) => Referral(
        code: json["code"],
        numberOfUsed: json["numberOfUsed"],
        userId: json["userId"],
      );

  Map<String , dynamic > toJson() => {
    "code":code,
    "numberOfUsed":numberOfUsed,
    "userId":userId
  };
}
