import 'package:equatable/equatable.dart';

class UserDetails extends Equatable {
   final String? refarCode;
  final String? name;
  final String? email;
  final String? phone;
  final String? photo;
  final String? id;
  final bool? isVerify;
  final bool? isPhoneVerify;
  final int freeWashTotal;
  final int freeWashUsed;
 

  const UserDetails({
    this.isVerify,
    this.name,
    this.phone,
    this.email,
    this.id,
    this.photo,
    this.isPhoneVerify,
    required this.freeWashUsed,
    required this.freeWashTotal,
    required this.refarCode,

  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "email": email,
        "id": id,
        "isEmailVerification": isVerify,
        "isPhoneVerification": isPhoneVerify,
        "photo": photo,
        "refarCode": refarCode,
        "freeWashTotal": freeWashTotal,
        "freeWashUsed": freeWashUsed,
   
      };

  @override
  List<Object?> get props => [id, phone, name, email];
}
