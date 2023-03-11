import 'package:dropeg/core/utils/app_colors.dart';
import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/core/utils/assets_manger.dart';
import 'package:dropeg/core/utils/components/app_buttons.dart';
import 'package:dropeg/core/utils/components/img_network_with_cached.dart';
import 'package:dropeg/features/order/domain/entities/required_service.dart';
import 'package:dropeg/features/order/presentation/cubit/order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RequiredServiceItem extends StatefulWidget {
  final RequiredService requiredService;

  const RequiredServiceItem({super.key, required this.requiredService});

  @override
  State<RequiredServiceItem> createState() => _RequiredServiceItemState();
}

class _RequiredServiceItemState extends State<RequiredServiceItem> {
  @override
  Widget build(BuildContext context) {
    bool isSelected = OrderCubit.get(context)
        .requiredSelected
        .contains(widget.requiredService);
    return GestureDetector(
      onTap: () {
        OrderCubit.get(context)
            .getAddItemToRequiredSelected(widget.requiredService);
      },
      child: Column(
        children: [
          Card(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(22.0),
              ),
            ),
            child: Container(
              height: 85.h,
              decoration: BoxDecoration(
                  border: isSelected
                      ? Border.all(color: AppColors.primaryColor, width: 2)
                      : null,
                  color: isSelected ? AppColors.shadowPrimaryColor : null,
                  borderRadius: BorderRadius.circular(22)),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ImageNetworkWithCached(
                        width: 72.h, imgUrl: widget.requiredService.imgUrl),
                    SizedBox(
                      width: 35.w,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.requiredService.name,
                            style: Theme.of(context).textTheme.displaySmall,
                            maxLines: 2,
                          ),
                          Row(
                            children: [
                              const Text(AppStrings.egp),
                              SizedBox(
                                width: 4.w,
                              ),
                              SizedBox(
                                  width: 35.w,
                                  child: Text(widget.requiredService.price)),
                              SizedBox(
                                height: 20,
                                child: _offsetPopup(),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    !isSelected
                        ? Container(
                            height: 20.h,
                            width: 20.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.white,
                            ),
                          )
                        : SvgPicture.asset(IconsManger.rightIcon),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 8.h,
          )
        ],
      ),
    );
  }

  Widget _offsetPopup() {
    return IconButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                    backgroundColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                              child: ImageNetworkWithCached(
                                  imgUrl: widget.requiredService.imgUrl)),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            widget.requiredService.name,
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          Text(widget.requiredService.details),
                          SizedBox(height: 16,),
                          Text(
                            widget.requiredService.benefits.isNotEmpty
                                ? AppStrings.benefits
                                : AppStrings.whatIsIncluded,
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          widget.requiredService.benefits.isNotEmpty
                              ? Text(widget.requiredService.benefits)
                              : Column(
                                  children: List.generate(
                                      widget.requiredService.whatIsIncluded
                                              ?.length ??
                                          0,
                                      (index) => Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 4.0),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.circle,
                                                  color: AppColors.primaryColor,
                                                ),
                                                SizedBox(
                                                  width: 8.w,
                                                ),
                                                Expanded(
                                                    child: Text(
                                                  widget.requiredService
                                                              .whatIsIncluded?[
                                                          index] ??
                                                      "",
                                                )),
                                              ],
                                            ),
                                          )),
                                ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              Card(
                                child: InkWell(
                                  onTap: (){
                                    Navigator.canPop(context)?Navigator.pop(context):SizedBox();
                                  },
                                  child: SizedBox(
                                    width: 90.w,
                                    height: 40.h,
                                    child: Center(
                                        child: Text(
                                      AppStrings.cancel,
                                      style:
                                          Theme.of(context).textTheme.headlineSmall,
                                    )),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                child: AppButtonBlue(
                                    text: AppStrings.addToCart,
                                    onTap: () {
                                      if (!OrderCubit.get(context)
                                          .requiredSelected
                                          .contains(widget.requiredService)) {
                                        OrderCubit.get(context)
                                            .getAddItemToRequiredSelected(
                                                widget.requiredService);
                                      }
                                      Navigator.pop(context);
                                    }),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ));
        },
        icon: Icon(Icons.info_outline_rounded, size: 14.h));
  }
}
