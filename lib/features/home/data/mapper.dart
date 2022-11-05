import 'package:dropeg/features/home/data/models/service_model.dart';
import 'package:dropeg/features/home/domain/entity/service_entity.dart';

extension ServiceProviderModelToDomain on ServiceProviderModel {
  ServiceProvider toDomain() =>
      ServiceProvider(title: title, details: details, id: id, img: img);
}
