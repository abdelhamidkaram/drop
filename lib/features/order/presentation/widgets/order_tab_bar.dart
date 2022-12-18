import 'package:dropeg/core/utils/app_colors.dart';
import 'package:dropeg/core/utils/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderTapBar extends StatelessWidget {
  final VoidCallback? interiorTap;
  final VoidCallback? exteriorTap;
  final bool isExterior;
  const OrderTapBar(
      {super.key,  this.interiorTap,  this.exteriorTap, required this.isExterior});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(40.0),
        ),
      ),
      child: SizedBox(
        height: 54.h,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: exteriorTap,
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          isExterior ? AppColors.primaryColor : AppColors.cardBackGround,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Center(
                      child: Text(
                        AppStrings.exterior,
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              color: !isExterior
                                  ? AppColors.primaryColor
                                  : AppColors.white,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: interiorTap,
                  child: Container(
                    decoration: BoxDecoration(
                      color: !isExterior
                          ? AppColors.primaryColor
                          : AppColors.cardBackGround,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Center(
                      child: Text(
                        AppStrings.interior,
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              color: isExterior
                                  ? AppColors.primaryColor
                                  : AppColors.white,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
