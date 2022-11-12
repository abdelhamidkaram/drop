import 'package:dropeg/core/utils/app_colors.dart';
import 'package:dropeg/core/utils/components/img_network_with_cached.dart';
import 'package:dropeg/features/home/features/services/domain/entity/service_entity.dart';
import 'package:dropeg/features/home/features/services/presentation/cubit/provider_services_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProviderServicesItem extends StatefulWidget {
  final ServiceProvider serviceProvider;
  final int index;
  const ProviderServicesItem(
      {super.key, required this.serviceProvider, required this.index});

  @override
  State<ProviderServicesItem> createState() => _ProviderServicesItemState();
}

class _ProviderServicesItemState extends State<ProviderServicesItem> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProviderServicesCubit, ProviderServicesState>(
      listener: (context, state) => ProviderServicesCubit(),
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            setState(() {
              isSelected = !isSelected;
              ProviderServicesCubit.get(context)
                  .changeSelectedProvider(widget.serviceProvider);
              ProviderServicesCubit.get(context).changeSelectedProviderServices(
                  widget.serviceProvider.serverProvideList?[widget.index]);
            });
          },
          child: Card(
            color: isSelected
                ? AppColors.shadowPrimaryColor
                : AppColors.cardBackGround,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: isSelected
                      ? Border.all(color: AppColors.primaryColor, width: 2)
                      : null),
              child: SizedBox(
                width: double.infinity,
                height: 94.h,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      ImageNetworkWithCached(
                        height: 80.h,
                        imgUrl: widget.serviceProvider
                                .serverProvideList?[widget.index].img ??
                            "",
                      ),
                      Expanded(
                        child: Text(
                            widget
                                    .serviceProvider
                                    .serverProvideList?[widget.index]
                                    .serviceName ??
                                "",
                            style: Theme.of(context).textTheme.headline3),
                      ),
                      !isSelected
                          ? Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.greyLight),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.backGround,
                                  )
                                ],
                              ),
                              child: Icon(
                                Icons.circle,
                                color: AppColors.white,
                              ))
                          : Icon(
                              Icons.check_circle,
                              color: AppColors.primaryColor,
                              size: 25,
                            )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
