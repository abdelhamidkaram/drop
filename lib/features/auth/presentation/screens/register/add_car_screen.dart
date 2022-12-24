import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropeg/core/api/firestore_strings.dart';
import 'package:dropeg/core/shared_prefs/app_prefs.dart';
import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/core/utils/toasts.dart';
import 'package:dropeg/features/auth/domain/entities/car.dart';
import 'package:flutter/material.dart';
import 'package:dropeg/core/utils/components/custom_appbar.dart';
import 'package:dropeg/core/utils/components/custom_text_field.dart';
import 'package:dropeg/features/auth/presentation/widgets/sign_up_btn.dart';
import 'package:dropeg/core/utils/constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uuid/uuid.dart';
import '../../../../../config/route/app_route.dart';
import '../../../../../main.dart';
import 'package:dropeg/injection_container.dart' as di;
import '../profile/bloc/cubit.dart';

class AddCarScreen extends StatefulWidget {
  final bool formProfileScreen;
  const AddCarScreen({Key? key, required this.formProfileScreen})
      : super(key: key);

  @override
  State<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
  var modelController = TextEditingController();
  var colorController = TextEditingController();
  var licenseNumberController = TextEditingController();
  var bController = TextEditingController();
  var cController = TextEditingController();
  var dController = TextEditingController();
  var licensePlateController = TextEditingController();
  var addCarFormKey = GlobalKey<FormState>();
  String? value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            CustomAppbars.loginAppbar(
          context: context, title: AppStrings.signUp, isAddScreen: true),
            Column(
              children: [
                const SizedBox(height: 210,),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: addCarFormKey,
                    child: Column(
                      children: [
                        manufacturer(),
                        CustomTextFormField(
                          hint: AppStrings.carModelHint,
                          controller: modelController,
                          type: TextInputType.text,
                          validateEmptyMSG: AppStrings.carModelHintEmptMSG,
                        ),
                        const SizedBox(height: 25),
                        CustomTextFormField(
                          hint: AppStrings.carColorlHint,
                          controller: colorController,
                          type: TextInputType.text,
                          validateEmptyMSG: AppStrings.carColorHintEmptMSG,
                        ),
                        const SizedBox(height: 25),
                        licensePlate(),
                        const SizedBox(height: 25),
                        SignUpBTN(
                          value: 0.0,
                          onTap: () async {
                            if (addCarFormKey.currentState!.validate()) {
                              AppToasts.loadingToast();
                              Car carDetails = Car(
                                licenseNumber: licenseNumberController.text,
                                brand: value,
                                color: colorController.text,
                                licensePlate: licensePlateController.text,
                                model: modelController.text,
                                id: const Uuid().v4(),
                              );

                              await FirebaseFirestore.instance
                                  .collection(FirebaseStrings.usersCollection)
                                  .doc(uId)
                                  .collection(FirebaseStrings.carCollection)
                                  .doc(carDetails.id)
                                  .set(carDetails.toJson())
                                  .then((value) async {
                                if (!(await di
                                    .sl<AppPreferences>()
                                    .isOnBoardingScreenViewed())) {
                                  await di
                                      .sl<ProfileCubit>()
                                      .getCars(isRefresh: true)
                                      .then((value) {
                                    Navigator.of(context).pushReplacementNamed(
                                        AppRouteStrings.onBoarding);
                                  });
                                  AppToasts.successToast(AppStrings.success);
                                  return;
                                } else if (widget.formProfileScreen) {
                                  ProfileCubit.get(context)
                                      .getCars(isRefresh: true)
                                      .then((value) {
                                        Navigator.of(context)
                                      .pushReplacementNamed(AppRouteStrings.account);
                                      AppToasts.successToast(AppStrings.success);
                                      });
                                  
                                  return;
                                } else {
                                  Navigator.of(context)
                                      .pushReplacementNamed(AppRouteStrings.home);
                                  AppToasts.successToast(AppStrings.success);
                                  return;
                                }
                              }).catchError((err) {
                                AppToasts.errorToast(err.toString());
                              });
                            }
                          },
                          editOnPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Row licensePlate() {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            child: CustomTextFormField(
              hint: AppStrings.carlicenseNumberHint,
              controller: licenseNumberController,
              type: TextInputType.number,
              validateEmptyMSG: AppStrings.carAHintEmptMSG,
            ),
          ),
        ),
        SizedBox(
          width: 5.w,
        ),
        Expanded(
          child: SizedBox(
            child: CustomTextFormField(
              hint: AppStrings.carLicensePlateHint,
              controller: licensePlateController,
              type: TextInputType.text,
              validateEmptyMSG: AppStrings.carLicensePlateHintEmptMSG,
            ),
          ),
        ),
      ],
    );
  }

  Column manufacturer() {
    return Column(
      children: [
        SizedBox(
          height: 65.h,
          child: Card(
            elevation: 5,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DropdownButtonFormField(
                  validator: (value) {
                    if (value == null) {
                      return AppStrings.manufacturerEmptMSG;
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  dropdownColor: Colors.white,
                  value: value,
                  hint: const Text(AppStrings.manufacturerHint),
                  onChanged: (newValue) {
                    setState(() {
                      value = newValue as String;
                    });
                  },
                  items: AppConstants.manufacturer
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(fontSize: 20),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }
}
