import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:netguru_task/base/models/error_code.dart';

@immutable
abstract class AddValueState extends Equatable {
  @override
  List<Object> get props => [];
}

class AddValueInitState extends AddValueState {}

class AddValueSavingState extends AddValueState {}

class AddValueSavedState extends AddValueState {}

class AddValueErrorState extends AddValueState {
  AddValueErrorState(this.errorCode);

  final ErrorCode errorCode;

  @override
  List<Object> get props => [errorCode];
}
