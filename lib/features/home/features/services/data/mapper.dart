import 'package:dropeg/features/home/features/services/domain/entity/service_entity.dart';
import 'models/service_model.dart';

extension ServiceProviderModelToDomain on ServiceProviderModel {
  ServiceProvider toDomain() => ServiceProvider(
      title: title,
      details: details,
      id: id,
      img: img,
      serverProvideList: serverProvideList ?? []
      
      );
}

extension ServiceModelToDomain on ServiceModel {
  ServiceEntity toDomain() => ServiceEntity(
      details: details,
      id: id,
      img: img,
      title: title,
      serviceProviders: serviceProviders);
}

extension ServiceProviderListModelToDomain on ServiceProvideListModel {
  ServiceProvideList toDomain() => ServiceProvideList(
      serviceName: serviceName, price: price, img: img, id: id);
}
