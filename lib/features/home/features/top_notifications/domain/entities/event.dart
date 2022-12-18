import 'package:equatable/equatable.dart';

class EventEntity extends Equatable {
  final String? id;
  final int? numberOfRegister;
  final String? date;
  final String? title;
  final String? details;
  final String? imgUrl;

  const EventEntity({
    required this.id,
    required this.title,
    required this.details,
    required this.imgUrl,
    required this.numberOfRegister,
    required this.date,
  });

  factory EventEntity.fromJson(Map<String, dynamic> json) => EventEntity(
      id: json["id"],
      title: json["title"],
      details: json["details"],
      imgUrl: json["imgUrl"],
      numberOfRegister: json["numberOfRegister"],
      date: json["date"]);

  Map<String, dynamic> toJson() => {
   'id' : id,
   "title": title,
   "details": details,
   "imgUrl": imgUrl,
   "numberOfRegister": numberOfRegister,
   "date": date,
  };
  @override
  List<Object?> get props => [id,title];
}
