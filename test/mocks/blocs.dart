import 'package:bloc_test/bloc_test.dart';
import 'package:netguru_task/modules/add_value/bloc/add_value_bloc.dart';
import 'package:netguru_task/modules/add_value/bloc/add_value_state.dart';
import 'package:netguru_task/modules/favorites/bloc/bloc.dart';
import 'package:netguru_task/modules/home/bloc/bloc.dart';

class MockHomeBloc extends MockBloc<HomeState> implements HomeBloc {}

class MockFavoritesBloc extends MockBloc<FavoritesState>
    implements FavoritesBloc {}

class MockAddValueBloc extends MockBloc<AddValueState> implements AddValueBloc {
}
