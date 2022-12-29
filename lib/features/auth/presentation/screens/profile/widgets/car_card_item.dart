import 'package:dropeg/features/auth/presentation/screens/profile/bloc/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_string.dart';
import '../../../../../../core/utils/components/app_buttons.dart';
import '../../../../../../core/utils/components/custom_text_field.dart';
import '../../../../../../core/utils/constant.dart';
import '../../../../domain/entities/car.dart';
import 'package:dropeg/injection_container.dart' as di;

import '../bloc/state.dart';

class CarCardItem extends StatefulWidget {
  final ProfileCubit profileCubit;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final int index;
  const CarCardItem({
    Key? key,
    required this.profileCubit,
    required this.index,
    required this.scaffoldKey,
  }) : super(key: key);

  @override
  State<CarCardItem> createState() => _CarCardItemState();
}

class _CarCardItemState extends State<CarCardItem> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    var modelController = TextEditingController(
        text: widget.profileCubit.cars?[widget.index].model);
    var colorController = TextEditingController(
        text: widget.profileCubit.cars?[widget.index].color);
    var licenseNumberController = TextEditingController(
        text: widget.profileCubit.cars?[widget.index].licenseNumber);
    String? value = widget.profileCubit.cars?[widget.index].brand;
    var licensePlateController = TextEditingController(
        text: widget.profileCubit.cars?[widget.index].licensePlate);
    Row licensePlate() {
      return Row(
        children: [
          SizedBox(
            width: 50,
            child: CustomTextFormField(
              hint: AppStrings.carLicenseNumberHint,
              controller: licenseNumberController,
              type: TextInputType.text,
              validateEmptyMSG: AppStrings.carAHintEmptyMSG,
            ),
          ),
          const SizedBox(
            width: 14,
          ),
          SizedBox(
            width: 150,
            child: CustomTextFormField(
              hint: AppStrings.carLicensePlateHint,
              controller: licensePlateController,
              type: TextInputType.text,
              validateEmptyMSG: AppStrings.carLicensePlateHintEmptyMSG,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      );
    }

    Column manufacturer() {
      return Column(
        children: [
          SizedBox(
            height: 70,
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
                        return AppStrings.manufacturerEmptyMSG;
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

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: GestureDetector(
        onTap: () {
          widget.scaffoldKey.currentState!.showBottomSheet((context) {
            return BottomSheet(
              enableDrag: false,
              onClosing: () {},
              builder: (context) => Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: formKey,
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () async {
                                    await ProfileCubit.get(context).deleteCar(
                                        index: widget.index, context: context);
                                  },
                                  child: Text(
                                    AppStrings.delete,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5!
                                        .copyWith(
                                          color: AppColors.red,
                                        ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    AppStrings.editCar,
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  ),
                                ),
                              ),
                              const Expanded(child: SizedBox())
                            ],
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          manufacturer(),
                          CustomTextFormField(
                            hint: AppStrings.carModelHint,
                            controller: modelController,
                            type: TextInputType.text,
                            validateEmptyMSG: AppStrings.carModelHintEmptyMSG,
                          ),
                          const SizedBox(height: 25),
                          CustomTextFormField(
                            hint: AppStrings.carColorHint,
                            controller: colorController,
                            type: TextInputType.text,
                            validateEmptyMSG: AppStrings.carColorHintEmptyMSG,
                          ),
                          const SizedBox(height: 25),
                          licensePlate(),
                          const SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: AppButtonBlue(
                                  text: AppStrings.editCar,
                                  onTap: () async {
                                    if (formKey.currentState!.validate()) {
                                      Car newCar = Car(
                                        licenseNumber:
                                            licenseNumberController.text,
                                        brand: value,
                                        color: colorController.text,
                                        licensePlate:
                                            licensePlateController.text,
                                        model: modelController.text,
                                        id: widget.profileCubit
                                            .cars![widget.index].id,
                                      );
                                      if (widget.profileCubit
                                              .cars![widget.index] ==
                                          newCar) {
                                        Navigator.pop(context);
                                      } else {
                                        await ProfileCubit.get(context)
                                            .getEditCar(
                                                context: context,
                                                index: widget.index,
                                                newCar: newCar);
                                      }
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Expanded(
                                child: AppButtonRed(
                                    text: AppStrings.cancel,
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    }),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          });
        },
        child: BlocConsumer<ProfileCubit, ProfileStates>(
          listener: (context, state) => di.sl<ProfileCubit>(),
          builder: (context, state) => Card(
            child: SizedBox(
              height: 72.h,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${widget.profileCubit.cars?[widget.index].brand ?? "."} ${widget.profileCubit.cars?[widget.index].model ?? "."}",
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          Text(
                            "${widget.profileCubit.cars?[widget.index].licensePlate ?? "."}-${widget.profileCubit.cars?[widget.index].licenseNumber ?? "."}",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios_rounded)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
