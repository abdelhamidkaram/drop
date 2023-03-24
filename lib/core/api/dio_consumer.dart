import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dropeg/core/api/api_cosumer.dart';
import 'package:dropeg/core/api/app_interceptors.dart';
import 'package:dropeg/core/api/end_points.dart';
import 'package:dropeg/core/api/status_code.dart';
import 'package:dropeg/core/utils/extensions.dart';
import 'package:dropeg/injection_container.dart' as di;
import 'package:flutter/foundation.dart';
import '../error/exception.dart';

class DioConsumer implements ApiConsumer {
  final Dio client;
  DioConsumer({required this.client}) {
    (client.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    client.options
      ..baseUrl = EndPoints.baseUrl
      ..responseType = ResponseType.plain
      ..followRedirects = false
      ..validateStatus = (status) {
        return status! < StatusCode.internalServerError;
      };
    client.interceptors.add(di.sl<AppInterceptors>());
    if (kDebugMode) {
      client.interceptors.add(di.sl<LogInterceptor>());
    }
  }
  @override
  Future getData(String path, {Map<String, dynamic>? queryParameters}) async {
    try{
      final response = await client.get(path, queryParameters: queryParameters);
      return response.jsonResponseToString;
    } on DioError catch(error){
      _handleDioError(error);
    }
  }

  @override
  Future postData(String path,
      {bool isFormData = false,
        Map<String, dynamic>? body,
        Map<String, dynamic>? queryParameters}) async {

    try{
      final response = await client.post(path,
          queryParameters: queryParameters,
          data: isFormData ? FormData.fromMap(body!) : body);
      return response.jsonResponseToString;
    }on DioError catch (error){
      _handleDioError(error);
    }

  }

  @override
  Future putData(String path,
      {Map<String, dynamic>? body,
        Map<String, dynamic>? queryParameters}) async {
    try{
      final response =
      await client.put(path, queryParameters: queryParameters, data: body);
      return response.jsonResponseToString;
    }on DioError catch (error){
      _handleDioError(error);
    }

  }
  dynamic _handleDioError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        throw const FetchDataException();
      case DioErrorType.response:
        switch (error.response?.statusCode) {
          case StatusCode.badRequest:
            throw const BadRequestException();
          case StatusCode.unAuthorized:
          case StatusCode.forbidden:
            throw const UnauthorizedException();
          case StatusCode.notFound:
            throw const NotFoundException();
          case StatusCode.conflict:
            throw const ConflictException();

          case StatusCode.internalServerError:
            throw const InternalServerErrorException();
        }
        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.other:
        throw const NoInternetConnectionException();
    }
  }
}