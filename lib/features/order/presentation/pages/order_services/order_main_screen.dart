import 'package:dropeg/config/route/app_route.dart';
import 'package:dropeg/config/route/app_route_arguments.dart';
import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/core/utils/components/app_buttons.dart';
import 'package:dropeg/core/utils/components/custom_appbar.dart';
import 'package:dropeg/features/order/presentation/cubit/order_cubit.dart';
import 'package:dropeg/features/order/presentation/widgets/order_tab_bar.dart';
import 'package:dropeg/features/order/presentation/widgets/requires_service_item.dart';
import 'package:dropeg/features/auth/domain/entities/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderMainScreen extends StatefulWidget {
  final LocationEntity location;
  const OrderMainScreen({super.key, required this.location});

  @override
  State<OrderMainScreen> createState() => _OrderMainScreenState();
}

class _OrderMainScreenState extends State<OrderMainScreen> {
  bool isExterior = true;
  @override
  void initState() {
    OrderCubit.get(context).getOrderLocation(location: widget.location);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        var exteriorServices =
            OrderCubit.get(context).exteriorServices.reversed.toList();
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
                        interiorTap: () {
                          Navigator.pushNamed(
                              arguments: OrderMainArgs(
                                  locationEntity:
                                      OrderCubit.get(context).orderLocation ??
                                          widget.location),
                              context,
                              AppRouteStrings.interior);
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
                              exteriorServices.length,
                              (index) => RequiredServiceItem(
                                requiredService: exteriorServices[index],
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
