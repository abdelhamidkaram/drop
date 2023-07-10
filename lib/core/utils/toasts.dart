import 'package:flutter_easyloading/flutter_easyloading.dart';
class AppToasts{
  static errorToast(String msg){
    EasyLoading.showError(msg);
  }
  static loadingToast(){

    EasyLoading.showToast("waiting" , duration: Duration(seconds: 1) , toastPosition: EasyLoadingToastPosition.bottom);
  }
  static successToast(String msg){
    /// disable after v1 beta comments
    //EasyLoading.showSuccess(msg);
  }
}