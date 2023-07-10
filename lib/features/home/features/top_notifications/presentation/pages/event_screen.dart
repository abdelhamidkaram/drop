import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropeg/config/route/app_route.dart';
import 'package:dropeg/core/api/firestore_strings.dart';
import 'package:dropeg/core/utils/app_colors.dart';
import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/core/utils/assets_manger.dart';
import 'package:dropeg/core/utils/components/app_buttons.dart';
import 'package:dropeg/core/utils/components/custom_appbar.dart';
import 'package:dropeg/core/utils/components/custom_text_field.dart';
import 'package:dropeg/core/utils/toasts.dart';
import 'package:dropeg/features/home/features/top_notifications/domain/entities/event.dart';
import 'package:dropeg/features/home/features/top_notifications/presentation/cubit/topnotifications_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventScreen extends StatefulWidget {
  final EventEntity event;

  const EventScreen({super.key, required this.event});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {

  @override
  void initState() {
    super.initState();
  }

  var nameController = TextEditingController();
  var idNumberController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 60.h,
                ),
                Container(
                  width: double.infinity,
                  height: 300.h,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: Image
                            .asset(
                          ImagesManger.eventScreen,
                        )
                            .image,
                        fit: BoxFit.cover),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50.0.h),
                        child: Column(
                          children: [
                            Text(
                              textAlign: TextAlign.center,
                              widget.event.title ?? " ",
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .displaySmall,
                              maxLines: 2,
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(widget.event.details ?? " "),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      TopNotificationsCubit
                          .get(context)
                          .successRegister() ?
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(width: 2,color: AppColors.primaryColor)
                        ),
                        color: Colors.white,
                        borderOnForeground: true,
                        child: Container(
                          padding: EdgeInsets.all(16),
                          height: 140.h,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("You’re Successfully Registered!" , style: Theme.of(context).textTheme.displayMedium,),
                              AppButtonBlue(text: AppStrings.done, onTap: (){
                                Navigator.pushNamed(context, AppRouteStrings.home);
                              })
                            ],
                          ),
                        ),

                      )
                          : Form(
                          key: formKey,
                          child: Column(
                            children: [
                              CustomTextFormField(
                                  hint: AppStrings.nameHINT,
                                  controller: nameController,
                                  validateEmptyMSG: " ^ ",
                                  type: TextInputType.name),
                              SizedBox(
                                height: 16.h,
                              ),
                              CustomTextFormField(
                                  hint: AppStrings.idNumberHINT,
                                  controller: idNumberController,
                                  validateEmptyMSG: " ^ ",
                                  type: TextInputType.number),
                              SizedBox(
                                height: 16.h,
                              ),
                              CustomTextFormField(
                                  hint: AppStrings.emailAddressHINT,
                                  controller: emailController,
                                  validateEmptyMSG: " ^ ",
                                  type: TextInputType.emailAddress),
                              SizedBox(
                                height: 16.h,
                              ),
                              CustomTextFormField(
                                  hint: AppStrings.phoneNumberHINT,
                                  controller: phoneController,
                                  validateEmptyMSG: " ^ ",
                                  type: TextInputType.phone),
                              SizedBox(
                                height: 18.h,
                              ),
                              AppButtonBlue(
                                  text: AppStrings.confirmReservation,
                                  onTap: () async {
                                    if (formKey.currentState!.validate()) {
                                      await FirebaseFirestore.instance
                                          .collection(
                                          FirebaseStrings.eventsCollection)
                                          .doc(widget.event.id)
                                          .collection(FirebaseStrings
                                          .eventsRegisterCollection)
                                          .doc(idNumberController.text)
                                          .set({
                                        "name": nameController.text,
                                        "idNumber": idNumberController.text,
                                        "email": emailController.text,
                                        "phone": phoneController.text,
                                      }).then((value) {
                                        AppToasts.successToast(
                                            AppStrings.success);
                                        setState(() {
                                          TopNotificationsCubit.get(context)
                                              .changeSuccessRegister(true);

                                        });
                                        TopNotificationsCubit.get(context)
                                            .changeEvent(false);
                                      });
                                    } else {
                                      AppToasts.errorToast("");
                                    }
                                  }),

                              SizedBox(height: 32.h,)
                            ],
                          )),
                    ],
                  ),
                )
              ],
            ),

            CustomAppbars.loginAppbar(
              context: context,
              title: "Event Reservations",
              isMyOrdersScreen: true,
              height: 233,
              color: Colors.transparent,
            ),

          ],
        ),
      ),
    );
  }
}
