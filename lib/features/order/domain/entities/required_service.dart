import 'package:equatable/equatable.dart';

class RequiredService extends Equatable {
  final String name;
  final String details;
  final String imgUrl;
  final String price;
  final String type;
  final String id;
  final String benefits;
  final List? whatIsIncluded;
  const RequiredService({
    required this.name,
    required this.details,
    required this.type,
    required this.imgUrl,
    required this.price,
    required this.id,
    required this.benefits,
    required this.whatIsIncluded,
  });

  factory RequiredService.fromJson(Map<String, dynamic> json) =>
      RequiredService(
          name: json["name"],
          details: json["details"],
          type: json["type"],
          imgUrl: json["imgUrl"],
          price: json["price"],
          id: json["id"],
          benefits: json["benefits"],
          whatIsIncluded: json["whatIsIncluded"],
           );

Map<String , dynamic> toJson() => {
"name" : name,
"details" : details,
"imgUrl" : imgUrl,
"type" : type,
"price" : price,
"id" : id,
"benefits" : benefits,
"whatIsIncluded" : whatIsIncluded,
};

  @override
  List<Object?> get props => [id,name,details,imgUrl,type];
}
