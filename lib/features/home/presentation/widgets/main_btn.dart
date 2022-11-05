import 'package:dropeg/core/utils/app_colors.dart';
import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/core/utils/assets_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.h,
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              height: 150.h,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      AppColors.blueDark,
                      AppColors.primaryColor
                    ],
                  ),
                  borderRadius: BorderRadius.circular(15)),
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
                          Row(
                            children: [
                              Text(
                                AppStrings.wash,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w700),
                              ),
                              Text(
                                AppStrings.drop,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
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
                                .headline5!
                                .copyWith(color: AppColors.white),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Icon(
              Icons.arrow_forward_ios_outlined,
              color: AppColors.white,
            ),
          )
        ],
      ),
    );
  }
}
