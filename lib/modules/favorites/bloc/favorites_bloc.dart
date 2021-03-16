import 'package:bloc/bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:meta/meta.dart';
import 'package:netguru_task/base/exceptions/storage_exception.dart';
import 'package:netguru_task/base/exceptions/unknown_exception.dart';
import 'package:netguru_task/base/models/error_code.dart';
import 'package:netguru_task/modules/values/repository/values_repository.dart';

import 'bloc.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc({
    @required this.valuesRepository,
    @required this.firebaseCrashlytics,
  }) : super(FavoritesInitState());

  final FirebaseCrashlytics firebaseCrashlytics;
  final ValuesRepository valuesRepository;

  @override
  Stream<FavoritesState> mapEventToState(FavoritesEvent event) async* {
    if (event is GetFavoritesValuesData) {
      yield FavoritesLoadingState();
      try {
        final values = await valuesRepository.getFavoritesValues();

        yield FavoritesLoadedState(values);
      } on StorageException {
        yield FavoritesErrorState(ErrorCode.storageError);
      } on UnknownErrorException {
        yield FavoritesErrorState(ErrorCode.unexpected);
      } catch (e, stack) {
        await firebaseCrashlytics.recordError(e, stack);
        yield FavoritesErrorState(ErrorCode.unexpected);
      }
    }
  }
}
