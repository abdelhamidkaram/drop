import 'package:dropeg/config/route/app_route.dart';
import 'package:dropeg/config/route/app_route_arguments.dart';
import 'package:dropeg/core/utils/components/img_network_with_cached.dart';
import 'package:dropeg/features/home/features/services/domain/entity/service_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServicesProviderListItem extends StatelessWidget {
  const ServicesProviderListItem({
    Key? key,
    required this.serviceEntity,
    required this.index,
  }) : super(key: key);

  final ServiceEntity serviceEntity;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        Navigator.pushNamed(context, AppRouteStrings.singleProviderServices,
            arguments: SingleProviderServicesArgs(
                   index: index,
                   serviceEntity: serviceEntity
                ));
      }),
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SizedBox(
                height: 69.h,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            serviceEntity.serviceProviders[index].title,
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          SizedBox(
                            height: 5.0.h,
                          ),
                          Text(
                            serviceEntity.serviceProviders[index].details,
                            style: const TextStyle(
                                overflow: TextOverflow.ellipsis),
                            maxLines: 3,
                          ),
                        ],
                      )),
                      ImageNetworkWithCached(
                        height: 100.h,
                        imgUrl: serviceEntity.serviceProviders[index].img,
                      ),
                      const Icon(Icons.arrow_forward_ios_outlined),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h)
        ],
      ),
    );
  }
}
