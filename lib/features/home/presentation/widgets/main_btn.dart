import 'package:dropeg/config/route/app_route.dart';
import 'package:dropeg/config/route/app_route_arguments.dart';
import 'package:dropeg/core/utils/app_colors.dart';
import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/core/utils/assets_manger.dart';
import 'package:dropeg/features/auth/domain/entities/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class MainButton extends StatelessWidget {
  final LocationEntity location ;
  const MainButton({
    Key? key,
     required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context, AppRouteStrings.order,
          arguments: OrderMainArgs(locationEntity: location )
        );
      },
      child: SizedBox(
        height: 150.h,
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                elevation: 12,
                shadowColor: Colors.black,
                child: Container(
                  height: 150.h,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          AppColors.primaryColor,
                          AppColors.primaryColor.withOpacity(0.75),
                        ],

                      ),
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          Lottie.asset(
                            JsonManger.washButton,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppStrings.wash,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayLarge!
                                            .copyWith(
                                                color: AppColors.white,
                                                fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        AppStrings.drop,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayLarge!
                                            .copyWith(
                                                color: AppColors.white,
                                                fontWeight: FontWeight.w300),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  Text(
                                    AppStrings.carWashAnyWhere,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(
                                      color: AppColors.white2,
                                      fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ],
                              )

                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30.0),
              child: Icon(

                Icons.arrow_forward_ios_outlined,
                color: AppColors.white,
                size: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}
