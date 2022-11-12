import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/core/utils/components/category_title.dart';
import 'package:dropeg/core/utils/components/custom_appbar.dart';
import 'package:dropeg/features/home/features/services/domain/entity/service_entity.dart';
import 'package:dropeg/features/home/features/services/presentation/widgets/provider_build_item.dart';
import 'package:flutter/material.dart';

class SingleProviderScreen extends StatelessWidget {
  final ServiceEntity serviceEntity;
  const SingleProviderScreen({super.key, required this.serviceEntity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 233),
          child: CustomAppbars.appBarWithCard(
              context: context,
              title: serviceEntity.title,
              subTitle: serviceEntity.details,
              img: serviceEntity.img)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            const SizedBox(
              height: 20,
            ),
            const CategoryTitle(title: AppStrings.availableProviders),
            const SizedBox(
              height: 20,
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
    );
  }
}
