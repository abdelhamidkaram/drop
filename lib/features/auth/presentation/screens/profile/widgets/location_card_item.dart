import 'package:dropeg/config/route/app_route.dart';
import 'package:dropeg/core/utils/components/location_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../../config/route/app_route_arguments.dart';
import '../../../../domain/entities/location.dart';

class LocationCardItem extends StatefulWidget {
  final List<LocationEntity> locations;

  final int index;

  const LocationCardItem(
      {Key? key, required this.index, required this.locations})
      : super(key: key);

  @override
  State<LocationCardItem> createState() => _LocationCardItemState();
}

class _LocationCardItemState extends State<LocationCardItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRouteStrings.location,
            arguments: LocationsArgs(
              locationEntity: widget.locations[widget.index],
              formProfileScreen: true,
            ));
      },
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                height: 64.h,
                width: 64.h,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1000)),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          locationIcon(widget.locations[widget.index].type!),
                          height: 30,
                          width: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 24,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.locations[widget.index].type ?? "..",
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(widget.locations[widget.index].address ?? ".."),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios_rounded)
            ],
          ),
          SizedBox(
            height: 16.h,
          )
        ],
      ),
    );
  }
}
