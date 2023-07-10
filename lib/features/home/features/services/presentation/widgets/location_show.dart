import 'package:dropeg/core/utils/app_colors.dart';
import 'package:dropeg/features/auth/domain/entities/location.dart';
import 'package:dropeg/features/home/bloc/home_cubit.dart';
import 'package:dropeg/features/home/bloc/home_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropeg/injection_container.dart' as di ;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LocationsShow extends StatefulWidget {
  final List<LocationEntity> locations;
  final LocationEntity currentLocation;

  const LocationsShow(
      {super.key, required this.locations, required this.currentLocation});

  @override
  State<LocationsShow> createState() => _LocationsShowState();
}
class _LocationsShowState extends State<LocationsShow> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) => di.sl<HomeCubit>(),
      listenWhen: (previous, current) => current is GetMainLocationSuccess,
      builder: (context, state) {
        // ignore: unused_local_variable
        var location = widget.currentLocation;
        return SizedBox(
          height: 320.h,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(
                height: 15.h,
              ),
              itemCount: widget.locations.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  HomeCubit.get(context).getMainLocation(
                      context: context, location: widget.locations[index]);
                  location = widget.locations[index];
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                child: Card(
                  color: widget.locations[index] ==
                          HomeCubit.get(context).mainLocation
                      ? AppColors.primaryColor
                      : null,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.locations[index].type ?? "",
                          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            color: widget.locations[index] ==
                                HomeCubit.get(context).mainLocation
                                ? AppColors.white
                                : null,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(widget.locations[index].address ?? "" , style: TextStyle(
                          color: widget.locations[index] ==
                              HomeCubit.get(context).mainLocation
                              ? AppColors.white
                              : null
                        ),),
                      ],
                    ),
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
