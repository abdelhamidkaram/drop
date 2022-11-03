import 'package:flutter_easyloading/flutter_easyloading.dart';
class AppToasts{
  static errorToast(String msg){
    EasyLoading.showError(msg);
  }
  static loadingToast(){

    EasyLoading.show(dismissOnTap: true);
  }
  static successToast(String msg){
    EasyLoading.showSuccess(msg);
  }
}