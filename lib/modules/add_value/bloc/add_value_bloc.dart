import 'package:bloc/bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:meta/meta.dart';
import 'package:netguru_task/base/exceptions/storage_exception.dart';
import 'package:netguru_task/base/exceptions/unknown_exception.dart';
import 'package:netguru_task/base/models/error_code.dart';
import 'package:netguru_task/modules/values/repository/values_repository.dart';

import 'bloc.dart';

class AddValueBloc extends Bloc<AddValueEvent, AddValueState> {
  AddValueBloc({
    @required this.valuesRepository,
    @required this.firebaseCrashlytics,
  }) : super(AddValueInitState());

  final FirebaseCrashlytics firebaseCrashlytics;
  final ValuesRepository valuesRepository;

  @override
  Stream<AddValueState> mapEventToState(AddValueEvent event) async* {
    if (event is AddNewValue) {
      yield AddValueSavingState();
      try {
        await valuesRepository.addNewValue(event.value);

        yield AddValueSavedState();
      } on StorageException {
        yield AddValueErrorState(ErrorCode.storageError);
      } on UnknownErrorException {
        yield AddValueErrorState(ErrorCode.unexpected);
      } catch (e, stack) {
        await firebaseCrashlytics.recordError(e, stack);
        yield AddValueErrorState(ErrorCode.unexpected);
      }
    } else if (event is ResetAddValue) {
      yield AddValueInitState();
    }
  }
}
