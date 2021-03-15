import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:netguru_task/modules/values/models/value.dart';

@immutable
abstract class HomeState extends Equatable {
  @override
  List<Object> get props => [];
}

class HomeInitState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  HomeLoadedState(this.values);

  final List<Value> values;

  @override
  List<Object> get props => [values];
}

class HomeErrorState extends HomeState {}
