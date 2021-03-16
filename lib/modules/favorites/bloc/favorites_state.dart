import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:netguru_task/base/models/error_code.dart';
import 'package:netguru_task/modules/values/models/value.dart';

@immutable
abstract class FavoritesState extends Equatable {
  @override
  List<Object> get props => [];
}

class FavoritesInitState extends FavoritesState {}

class FavoritesLoadingState extends FavoritesState {}

class FavoritesLoadedState extends FavoritesState {
  FavoritesLoadedState(this.values);

  final List<Value> values;

  @override
  List<Object> get props => [values];
}

class FavoritesErrorState extends FavoritesState {
  FavoritesErrorState(this.errorCode);

  final ErrorCode errorCode;

  @override
  List<Object> get props => [errorCode];
}
