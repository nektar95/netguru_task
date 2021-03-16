import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FavoritesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetFavoritesValuesData extends FavoritesEvent {}
