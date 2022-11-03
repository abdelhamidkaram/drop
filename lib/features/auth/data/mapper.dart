import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/features/auth/data/models/user_model.dart';
import 'package:dropeg/features/auth/domain/entities/car.dart';
import 'package:dropeg/features/auth/domain/entities/compound.dart';
import 'package:dropeg/features/auth/domain/entities/location.dart';
import 'package:dropeg/features/auth/domain/entities/user.dart';

extension Usermodelmapper on UserDetailsModel {
  UserDetails toDomain() => UserDetails(
        email: email ?? "",
        name: name ?? "",
        id: id ?? "",
        isVerify: isVerify ?? false,
        phone: phone ?? "",
        photo: photo ?? "",
        isPhoneVerify: isPhoneVerify ?? false,
        refarCode: refarCode ?? "",
      );
}

extension LocationEntityMapper on LocationEntity {
  LocationEntity toDomain() => LocationEntity(
      address: address ?? "",
      state: state ?? "",
      city: city ?? "",
      type: type ?? AppStrings.locationTypeOther,
      id: id,
  );
}

extension CarEntityMapper on Car {
  Car toDomain() => Car(
      a: a ?? "",
      b: b ?? "",
      c: c ?? "",
      brand: brand ?? "",
      color: color ?? "",
      licensePlate: licensePlate ?? "",
      model: model ?? "",
      id: id);
}

extension CompoundMapper on Compound {
  Compound toDomain() => Compound(
    name: name ?? "",
    address: address ?? "",
    imgUrl: imgUrl ?? "",
  );
}
