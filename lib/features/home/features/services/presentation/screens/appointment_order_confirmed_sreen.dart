import 'package:dropeg/config/route/app_route.dart';
import 'package:dropeg/core/utils/app_colors.dart';
import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/core/utils/components/app_buttons.dart';
import 'package:dropeg/core/utils/components/category_title.dart';
import 'package:dropeg/core/utils/components/img_network_with_cached.dart';
import 'package:dropeg/features/auth/presentation/widgets/hello_there.dart';
import 'package:dropeg/features/home/features/services/domain/entity/service_entity.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class SingleProviderOrderConfirmedScreen extends StatelessWidget {
  final ServiceProvideList? serviceProvideList;
  const SingleProviderOrderConfirmedScreen(
      {super.key, required this.serviceProvideList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: Text(
                  AppStrings.orderConfirmed,
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(color: AppColors.primaryColor),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children:const [
                   HelloThere(
                      title: AppStrings.whooraaay,
                      subtitle: AppStrings.yourAppointmentIsConfirmed),
                ],
              ),
              const Spacer(),
              serviceProvideList != null
                  ? Card(
                      child: SizedBox(
                        height: 97.h,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric( horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                   Text(AppStrings.orderedServices , style: Theme.of(context).textTheme.headline3),
                                  Row(
                                    children: [
                                      ImageNetworkWithCached(
                                          imgUrl: serviceProvideList!.img , 
                                          width: 20,
                                          ),
                                      SizedBox(
                                        width: 16.h,
                                      ),
                                      Text(
                                        serviceProvideList!.serviceName,
                                        style:
                                            Theme.of(context).textTheme.headline5,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                             const Spacer(),
                              Row(
                                children: [
                                  Text(
                                    AppStrings.egp,
                                    style: Theme.of(context).textTheme.headline5,
                                  ),
                                  Text(
                                    serviceProvideList!.price,
                                    style: Theme.of(context).textTheme.headline5,
                                  ),
                                ],
                              )
                              ,SizedBox(width: 5.w,)
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
        ),
      ),
    );
  }
}
