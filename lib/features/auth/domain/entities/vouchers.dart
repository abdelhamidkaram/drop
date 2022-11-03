class Voucher {
  final String? title;
  final String? discount;
  final String? details;
  final String? endDate;
  final String? code;
  Voucher(this.details, this.discount, this.endDate, this.title, this.code);
  factory Voucher.formJson(Map<String, dynamic> json) => Voucher(
        json["details"],
        json["discount"],
        json["endDate"],
        json["title"],
        json["id"],
      );

  Map<String, dynamic> toJson() => {
        "details": details,
        "discount": discount,
        "endDate": endDate,
        "title": title,
        "id": code
      };
}
