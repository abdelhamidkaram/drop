import 'package:dropeg/config/route/app_route.dart';
import 'package:dropeg/core/utils/app_colors.dart';
import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/core/utils/assets_manger.dart';
import 'package:dropeg/core/utils/components/app_buttons.dart';
import 'package:dropeg/core/utils/components/img_network_with_cached.dart';
import 'package:dropeg/features/auth/presentation/widgets/hello_there.dart';
import 'package:dropeg/features/home/features/services/domain/entity/service_entity.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class SingleProviderOrderConfirmedScreen extends StatefulWidget {
  final ServiceProvideList? serviceProvideList;
  const SingleProviderOrderConfirmedScreen(
      {super.key, required this.serviceProvideList});

  @override
  State<SingleProviderOrderConfirmedScreen> createState() => _SingleProviderOrderConfirmedScreenState();
}

class _SingleProviderOrderConfirmedScreenState extends State<SingleProviderOrderConfirmedScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: SafeArea(
          child: Column(
             mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Center(
                child: Text(
                  AppStrings.orderConfirmed,
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(color: AppColors.primaryColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children:const [
                     HelloThere(
                        title: AppStrings.whooraaay,
                        subtitle: AppStrings.yourAppointmentIsConfirmed),
                  ],
                ),
              ),
              Center(
                child: Container(
                  height: 250.h,
                  child: Lottie.asset(
                    JsonManger.workShopAppointment ,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    widget.serviceProvideList != null
                    ? Card(
                        child: SizedBox(
                          height: 95.h,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                 Text(AppStrings.orderedServices , style: Theme.of(context).textTheme.displaySmall),
                                SizedBox(
                                  height: 50.h,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          ImageNetworkWithCached(
                                              imgUrl: widget.serviceProvideList!.img ,
                                              width: 20.h,
                                              height: 20.h,
                                              ),
                                          SizedBox(
                                            width: 16.h,
                                          ),
                                          Text(
                                            widget.serviceProvideList!.serviceName,
                                            style:Theme.of(context).textTheme.headlineSmall,
                                          ),
                                          const Spacer(),
                                          Row(
                                            children: [
                                              Text(
                                                AppStrings.egp,
                                                style: Theme.of(context).textTheme.headlineSmall,
                                              ),
                                              const SizedBox(width: 5),
                                              Text(
                                                widget.serviceProvideList!.price,
                                                style: Theme.of(context).textTheme.headlineSmall,
                                              ),
                                            ],
                                          ),

                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
                SizedBox(
                  height: 20.h,
                ),
                AppButtonBlue(
                    text: AppStrings.home,
                    onTap: () {
                      Navigator.pushNamed(context, AppRouteStrings.home);
                    }),
           
           
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
