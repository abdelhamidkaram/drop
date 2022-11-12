import 'package:dropeg/config/route/app_route.dart';
import 'package:dropeg/config/route/app_route_arguments.dart';
import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/core/utils/components/app_buttons.dart';
import 'package:dropeg/core/utils/components/custom_appbar.dart';
import 'package:dropeg/features/home/features/services/domain/entity/service_entity.dart';
import 'package:dropeg/features/home/features/services/presentation/cubit/provider_services_cubit.dart';
import 'package:dropeg/features/home/features/services/presentation/widgets/single_provide_service_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SingleProviderServicesScreen extends StatefulWidget {
  final ServiceEntity serviceEntity;
  final int index;
  const SingleProviderServicesScreen(
      {super.key, required this.serviceEntity, required this.index});

  @override
  State<SingleProviderServicesScreen> createState() =>
      _SingleProviderServicesScreenState();
}

class _SingleProviderServicesScreenState
    extends State<SingleProviderServicesScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProviderServicesCubit, ProviderServicesState>(
      builder: (context, state) {
        return Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size(double.infinity, 233),
              child: CustomAppbars.appBarWithCard(
                  context: context,
                  title: widget.serviceEntity.serviceProviders[widget.index].title,
                  subTitle: widget.serviceEntity.serviceProviders[widget.index].details,
                  img: widget.serviceEntity.serviceProviders[widget.index].img)),
          body: (widget.serviceEntity.serviceProviders[widget.index] .serverProvideList != null &&
                  widget.serviceEntity.serviceProviders[widget.index].serverProvideList!.isNotEmpty)
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount:
                        widget.serviceEntity.serviceProviders[widget.index].serverProvideList?.length ?? 0,
                    itemBuilder: (context, index) => ProviderServicesItem(
                      serviceProvider: widget.serviceEntity.serviceProviders[widget.index],
                      index: index,
                    ),
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 16.h),
                  ),
                )
              : const Center(
                  child: Text(AppStrings.noServices),
                ),
          persistentFooterButtons: [
            AppButtonBlue(
                text: AppStrings.scheduleAppointment,
                onTap: () {
                  Navigator.pushNamed(context,
                      AppRouteStrings.singleProviderScheduleAppointment,
                      arguments:
                          ScheduleAppointmentArgs(
                            serviceEntity: widget.serviceEntity,
                            index: widget.index,
                            serviceProvideList : ProviderServicesCubit.get(context).selectedProviderServices
                            ),
                            );
                })
          ],
        );
      },
    );
  }
}
