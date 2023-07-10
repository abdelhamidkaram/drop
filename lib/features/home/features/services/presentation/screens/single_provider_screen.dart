import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/core/utils/components/category_title.dart';
import 'package:dropeg/core/utils/components/custom_appbar.dart';
import 'package:dropeg/features/home/features/services/domain/entity/service_entity.dart';
import 'package:dropeg/features/home/features/services/presentation/widgets/provider_build_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SingleProviderScreen extends StatelessWidget {
  final ServiceEntity serviceEntity;
  const SingleProviderScreen({super.key, required this.serviceEntity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 190.h,
              child: CustomAppbars.appBarWithCard(
                  context: context,
                  title: serviceEntity.title,
                  subTitle: serviceEntity.details,
                  img: serviceEntity.img , 
                  ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                
                children: [
                   SizedBox(
                    height: 13.h,
                  ),
                  const CategoryTitle(title: AppStrings.availableProviders),
                   SizedBox(
                    height: 13.h,
                  ),
                  Column(
                    children: List.generate(
                        serviceEntity.serviceProviders.length,
                        (index) => ServicesProviderListItem(
                              serviceEntity: serviceEntity,
                              index: index,
                            )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
