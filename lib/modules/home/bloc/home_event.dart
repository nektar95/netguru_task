import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetValuesData extends HomeEvent {}

class AddValueToFavorites extends HomeEvent {
  AddValueToFavorites(this.id);

  final int id;

  @override
  List<Object> get props => [id];
}
