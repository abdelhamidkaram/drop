import 'package:dropeg/core/utils/components/img_network_with_cached.dart';
import 'package:dropeg/features/order/domain/entities/required_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderSummaryWidget extends StatelessWidget {
  const OrderSummaryWidget({
    Key? key,
    required this.requiredSelected,
  }) : super(key: key);

  final List<RequiredService> requiredSelected;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: List.generate(
              requiredSelected.length,
              (index) => Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ImageNetworkWithCached(
                        imgUrl: requiredSelected[index].imgUrl,
                        height: 35.h,
                        width: 60.w,
                      ),
                      index != requiredSelected.length - 1
                          ? const Icon(
                              Icons.add,
                              size: 30,
                            )
                          : const SizedBox(),
                    ],
                  )),
        ),
      ),
    );
  }
}
