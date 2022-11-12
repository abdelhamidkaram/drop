
import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/core/utils/assets_manger.dart';

String locationIcon(String type) {
  switch (type) {
    case AppStrings.locationTypeHome:
      return IconsManger.locationHome;
    case AppStrings.locationTypeOffice:
      return IconsManger.locationOffice;
    case AppStrings.locationTypeParking:
      return IconsManger.locationParking;
    default:
      return IconsManger.locationOther;
  }
}