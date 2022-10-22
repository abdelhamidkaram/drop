import 'package:dropeg/features/auth/domain/entities/user.dart';

class UserDetailsModel extends UserDetails {
  UserDetailsModel(
      {required super.refreshToken,
      required super.isVerify,
      required super.name,
      required super.phone,
      required super.email,
      required super.id}) ;
}
