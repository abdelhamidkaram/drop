import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropeg/config/route/app_route.dart';
import 'package:dropeg/config/route/app_route_arguments.dart';
import 'package:dropeg/core/api/firestore_strings.dart';
import 'package:dropeg/core/utils/app_colors.dart';
import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/core/utils/components/app_buttons.dart';
import 'package:dropeg/core/utils/components/category_title.dart';
import 'package:dropeg/core/utils/components/img_network_with_cached.dart';
import 'package:dropeg/features/home/features/services/domain/entity/service_entity.dart';
import 'package:dropeg/features/home/features/services/presentation/cubit/provider_services_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uuid/uuid.dart';

import '../../../../../../core/utils/toasts.dart';
import '../../../../../../main.dart';

class CalenderBottomSheetWidget extends StatefulWidget {
  final ProviderServicesCubit cubit;
  final ServiceEntity serviceEntity;
  final int index;
  final ServiceProvideList? serviceProvideList;
  const CalenderBottomSheetWidget({
    required this.cubit,
    Key? key,
    required this.serviceEntity,
    required this.index,
    required this.serviceProvideList,
  }) : super(key: key);

  @override
  State<CalenderBottomSheetWidget> createState() =>
      _CalenderBottomSheetWidgetState();
}

class _CalenderBottomSheetWidgetState extends State<CalenderBottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    List<ServiceProvider>? providers = widget.serviceEntity.serviceProviders;
    ServiceProvideList? value = widget.serviceProvideList ??
        widget.cubit.selectedProvider?.serverProvideList?[0];
    return BlocConsumer<ProviderServicesCubit, ProviderServicesState>(
      listener: (context, state) => ProviderServicesCubit(),
      builder: (context, state) {
        return BottomSheet(
          enableDrag: false,
          onClosing: () {},
          builder: (context) => Container(
            height: 360.h,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: AppColors.white),
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  SizedBox(
                    height: 350.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Text(
                              AppStrings.provider,
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            Expanded(
                              child: Text(
                                widget.cubit.selectedProvider?.title ??
                                    widget.serviceEntity
                                        .serviceProviders[widget.index].title,
                                maxLines: 1,
                                style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            AppChangeButton(
                                text: AppStrings.change,
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => Dialog(
                                            child: SizedBox(
                                              height: 300.h,
                                              child: ListView.separated(
                                                itemCount: providers.length,
                                                itemBuilder: (context, index) =>
                                                    ListTile(
                                                  onTap: () {
                                                    widget.cubit
                                                        .changeSelectedProvider(
                                                            providers[index]);
                                                    Navigator.pop(context);
                                                  },
                                                  title: Text(
                                                      providers[index].title),
                                                  leading:
                                                      ImageNetworkWithCached(
                                                    imgUrl:
                                                        providers[index].img,
                                                    height: 70.h,
                                                  ),
                                                  subtitle: Text(
                                                      providers[index].details),
                                                ),
                                                separatorBuilder:
                                                    (context, index) =>
                                                        SizedBox(
                                                  height: 16.0.h,
                                                  width: double.infinity,
                                                  child: Center(
                                                      child: Divider(
                                                    color: AppColors.black,
                                                    height: 2,
                                                  )),
                                                ),
                                              ),
                                            ),
                                          ));
                                }),
                          ],
                        ),
                        const CategoryTitle(title: AppStrings.selectedService),
                        Card(
                          child: SizedBox(
                            height: 45.h,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Center(
                                child: DropdownButtonFormField(
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  dropdownColor: Colors.white,
                                  value: value?.serviceName ?? "service",
                                  hint: Text(value?.serviceName ?? "service"),
                                  onChanged: (newValue) {
                                    ServiceProvideList?
                                        selectedProviderServices() {
                                      for (var element in widget
                                          .serviceEntity
                                          .serviceProviders[widget.index]
                                          .serverProvideList!) {
                                        if (element.serviceName ==
                                            newValue.toString()) {
                                          return element;
                                        }
                                      }
                                    }

                                    ProviderServicesCubit.get(context)
                                        .changeSelectedProviderServices(
                                            selectedProviderServices());
                                  },
                                  items: widget.cubit.selectedProvider
                                          ?.serverProvideList
                                          ?.map<DropdownMenuItem<String>>(
                                              (value) {
                                        return DropdownMenuItem<String>(
                                          value: value.serviceName,
                                          child: Text(
                                            value.serviceName,
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),
                                        );
                                      }).toList() ??
                                      [
                                        DropdownMenuItem<String>(
                                          value:
                                              value?.serviceName ?? "service",
                                          child: Text(
                                            value?.serviceName ?? "service",
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),
                                        )
                                      ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const CategoryTitle(title: AppStrings.addAComment),
                        Card(
                          child: TextFormField(
                            controller: widget.cubit.commentController,
                            keyboardType: TextInputType.multiline,
                            maxLength: 250,
                            maxLines: 4,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: AppStrings.addACommentHit,
                                hintMaxLines: 6),
                          ),
                        ),
                        ElevatedButton(onPressed: () {}, child: Text("gg")),
                        AppButtonBlue(
                            text: AppStrings.confirmAppointment,
                            onTap: () async {
                              AppToasts.loadingToast();
                              String serviceUuid =
                                  const Uuid().v4().toString().substring(0, 20);
                              var data = {
                                "provider": ProviderServicesCubit.get(context)
                                    .selectedProvider!
                                    .toJson(),
                                "services": widget.serviceProvideList?.toJson(),
                                "price": widget.serviceProvideList?.price,
                                "userId": uId,
                                "appointment":
                                    ProviderServicesCubit.get(context)
                                        .selectedTime,
                                "status": false,
                                "comment": ProviderServicesCubit.get(context)
                                    .commentController
                                    .text,
                                "id": serviceUuid
                              };
                              await FirebaseFirestore.instance
                                  .collection(FirebaseStrings.appointmentsList)
                                  .doc(serviceUuid)
                                  .set(data)
                                  .then((value) {
                                Navigator.pushNamed(
                                  context,
                                  AppRouteStrings.singleProviderOrderConfirmed,
                                  arguments: SingleProviderOrderConfirmedArgs(
                                    serviceProvideList:
                                        widget.serviceProvideList,
                                  ),
                                );
                                AppToasts.successToast(AppStrings.success);
                              }).catchError((e) {
                                AppToasts.errorToast(AppStrings.errorInternal);
                                debugPrint(e.toString());
                              });
                            })
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
