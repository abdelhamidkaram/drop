import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/core/utils/components/app_buttons.dart';
import 'package:dropeg/core/utils/components/custom_appbar.dart';
import 'package:dropeg/features/Order/presentation/cubit/order_cubit.dart';
import 'package:dropeg/features/Order/presentation/widgets/order_tab_bar.dart';
import 'package:dropeg/features/Order/presentation/widgets/requires_service_item.dart';
import 'package:dropeg/features/auth/domain/entities/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InteriorScreen extends StatefulWidget {
  final LocationEntity location;
  const InteriorScreen({super.key, required this.location});

  @override
  State<InteriorScreen> createState() => _InteriorScreenState();
}

class _InteriorScreenState extends State<InteriorScreen> {
  bool isExterior = false;
  @override
  void initState() {
    OrderCubit.get(context).getOrderLocation(location: widget.location);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        var interiorServices =
            OrderCubit.get(context).interiorServices.reversed.toList();
        return Scaffold(
          persistentFooterButtons: [
            OrderButton(
                        isExterior: isExterior,
                        location: widget.location,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
          ],
          body: SingleChildScrollView(
            child: Column(
              children: [
                CustomAppbars.homeAppBar(
                  context: context,
                  onTap: null,
                  helloTitle: AppStrings.pleaseSelectedService,
                  hellosubTitle: AppStrings.startingByYourCars,
                  height: 233,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      OrderTapBar(
                        exteriorTap: () {
                          if (Navigator.canPop(context)) {
                            Navigator.pop(context);
                          }
                        },
                        isExterior: isExterior,
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      Column(
                        children: [
                          Column(
                            children: List.generate(
                              interiorServices.length,
                              (index) => RequiredServiceItem(
                                requiredService: interiorServices[index],
                              ),
                            ),
                          )
                        ],
                      ),
                      
                    ],
                  ),
                ),
              

              
              ],
            ),
          ),
        );
      },
    );
  }
}
