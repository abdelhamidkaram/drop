import 'package:equatable/equatable.dart';

class UserDetails extends Equatable {
   final String?  name;
   final String?  email;
  final  String? phone;
  final  String? photo;
  final  String?  id;
  final  bool? isVerify;
  final  bool? isPhoneVerify;

   const UserDetails(
      {
      this.isVerify,
       this.name,
       this.phone,
       this.email,
       this.id,
       this.photo,
        this.isPhoneVerify,

      });

  Map<String , dynamic > toJson()=>{
    "name":name,
    "phone":phone,
    "email":email,
    "id":id,
    "isEmailVerification":isVerify,
    "isPhoneVerification":isPhoneVerify,
    "photo" : photo
  };
  @override
  List<Object?> get props => [id, phone, name, email];
}
