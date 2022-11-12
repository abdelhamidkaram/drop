import 'package:dropeg/core/utils/app_colors.dart';
import 'package:dropeg/core/utils/assets_manger.dart';
import 'package:dropeg/core/utils/components/custom_back_button.dart';
import 'package:dropeg/features/home/features/services/domain/entity/service_entity.dart';
import 'package:dropeg/features/home/features/services/presentation/cubit/provider_services_cubit.dart';
import 'package:dropeg/features/home/features/services/presentation/widgets/calender_bottom_sheet_widget.dart';
import 'package:dropeg/features/home/features/services/presentation/widgets/calender_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScheduleAppointmentScreen extends StatefulWidget {
  final ServiceEntity serviceEntity;
  final int index;
  final ServiceProvideList? serviceProvideList;
  const ScheduleAppointmentScreen(
      {super.key,
      required this.serviceEntity,
      required this.index,
      required this.serviceProvideList});

  @override
  State<ScheduleAppointmentScreen> createState() =>
      _ScheduleAppointmentScreenState();
}

class _ScheduleAppointmentScreenState extends State<ScheduleAppointmentScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProviderServicesCubit, ProviderServicesState>(
      listener: (context, state) => ProviderServicesCubit(),
      builder: (context, state) {
        var cubit = ProviderServicesCubit.get(context);
        return Scaffold(
          backgroundColor: AppColors.lightPrimaryColor,
          appBar: AppBar(
            title: Image.asset(
              ImagesManger.logo,
              color: AppColors.white,
            ),
            leading: const Padding(
              padding: EdgeInsets.all(8.0),
              child: CustomBackButton(),
            ),
          ),
          body: CalenderWidget(cubit: cubit),
          bottomSheet: CalenderBottomSheetWidget(
              cubit: cubit,
              serviceEntity: widget.serviceEntity,
              index: widget.index,
              serviceProvideList: widget.serviceProvideList),
        );
      },
    );
  }
}
