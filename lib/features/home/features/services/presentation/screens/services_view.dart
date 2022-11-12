import 'package:dropeg/config/route/app_route.dart';
import 'package:dropeg/config/route/app_route_arguments.dart';
import 'package:dropeg/core/utils/components/img_network_with_cached.dart';
import 'package:dropeg/features/home/features/services/domain/entity/service_entity.dart';
import 'package:dropeg/features/home/bloc/home_cubit.dart';
import 'package:dropeg/features/home/bloc/home_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dropeg/injection_container.dart' as di;

class ServicesListView extends StatelessWidget {
  const ServicesListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) => di.sl<HomeCubit>,
      listenWhen: (previous, current) =>
          (current is GetServicesSuccess || current is GetServicesError),
      builder: (context, state) {
        if (state is GetServicesloading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        if (state is GetServicesError) {
          return Text(state.msg);
        } else {
          List<ServiceEntity> services = HomeCubit.get(context).services;
          return Column(
            children: [
              Column(
                children: List.generate(
                    services.length,
                    (index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRouteStrings.singleProvider,
                                  arguments:
                                      SingleProviderArgs(services[index]));
                            },
                            child: Card(
                              child: SizedBox(
                                height: 96.h,
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    children: [
                                      ImageNetworkWithCached(
                                        imgUrl:  services[index].img ,
                                        width: 65.w,
                                        ),
                                      SizedBox(
                                        width: 16.0.w,
                                      ),
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            services[index].title,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline3,
                                          ),
                                          SizedBox(
                                            height: 5.0.h,
                                          ),
                                          Text(
                                            services[index].details,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 3,
                                          ),
                                        ],
                                      )),
                                      const Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        size: 22,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )),
              ),
            ],
          );
        }
      },
    );
  }
}
