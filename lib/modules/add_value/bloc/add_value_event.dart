import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AddValueEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddNewValue extends AddValueEvent {
  AddNewValue(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class ResetAddValue extends AddValueEvent {}
