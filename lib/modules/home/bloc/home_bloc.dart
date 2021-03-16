import 'package:bloc/bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:meta/meta.dart';
import 'package:netguru_task/base/exceptions/storage_exception.dart';
import 'package:netguru_task/base/exceptions/unknown_exception.dart';
import 'package:netguru_task/base/models/error_code.dart';
import 'package:netguru_task/modules/values/repository/values_repository.dart';

import 'bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    @required this.valuesRepository,
    @required this.firebaseCrashlytics,
  }) : super(HomeInitState());

  final FirebaseCrashlytics firebaseCrashlytics;
  final ValuesRepository valuesRepository;

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is GetValuesData) {
      yield HomeLoadingState();
      try {
        final values = await valuesRepository.getValues();

        yield HomeLoadedState(values);
      } on StorageException {
        yield HomeErrorState(ErrorCode.storageError);
      } on UnknownErrorException {
        yield HomeErrorState(ErrorCode.unexpected);
      } catch (e, stack) {
        await firebaseCrashlytics.recordError(e, stack);
        yield HomeErrorState(ErrorCode.unexpected);
      }
    } else if (event is AddValueToFavorites) {
      try {
        final values = await valuesRepository.changeValue(event.id);
        yield HomeLoadedState(values);
      } on StorageException {
        yield HomeErrorState(ErrorCode.storageError);
      } on UnknownErrorException {
        yield HomeErrorState(ErrorCode.unexpected);
      } catch (e, stack) {
        await firebaseCrashlytics.recordError(e, stack);
        yield HomeErrorState(ErrorCode.unexpected);
      }
    }
  }
}
