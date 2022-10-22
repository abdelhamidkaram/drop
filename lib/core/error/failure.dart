import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable{
  final String message;
  final int code;
  const Failure({required this.message , required this.code});
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure{
  const ServerFailure({required super.message, required super.code});
}

class CacheFailure extends Failure{
  const CacheFailure({required super.message, required super.code});

}

class NetworkFailure extends Failure{
  const NetworkFailure({required super.message, required super.code});
}