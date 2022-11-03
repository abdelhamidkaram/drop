part of 'myorder_cubit.dart';

abstract class MyorderStates extends Equatable {
  const MyorderStates();

  @override
  List<Object> get props => [];
}

class MyorderInitial extends MyorderStates {}

class GetMyorderloading extends MyorderStates {}

class GetMyordersuccess extends MyorderStates {}

class GetMyorderError extends MyorderStates {}
