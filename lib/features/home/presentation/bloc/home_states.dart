import 'package:equatable/equatable.dart';

abstract class HomeStates extends Equatable {}
 class HomeStateInit extends HomeStates {
  @override
  List<Object?> get props => [];
 }

class GetMainLocationSuccess extends HomeStates {
  @override
  List<Object?> get props => [];
}
class GetMainLocationError extends HomeStates {
  @override
  List<Object?> get props => [];
}

class GetMainLocationloading extends HomeStates {
  @override
  List<Object?> get props => [];
}


