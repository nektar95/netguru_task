import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguru_task/modules/home/bloc/bloc.dart';
import 'package:netguru_task/modules/values/ui/values_container.dart';

class ValuesPage extends StatefulWidget {
  @override
  _ValuesPageState createState() => _ValuesPageState();
}

class _ValuesPageState extends State<ValuesPage> {
  @override
  void initState() {
    BlocProvider.of<HomeBloc>(context).add(GetValuesData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoadingState) {
          return const CircularProgressIndicator();
        } else if (state is HomeLoadedState) {
          return ValuesContainer(
            values: state.values,
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
