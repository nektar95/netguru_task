import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguru_task/modules/add_value/bloc/add_value_bloc.dart';
import 'package:netguru_task/modules/add_value/bloc/bloc.dart';

class AddValuePage extends StatefulWidget {
  @override
  _AddValuePageState createState() => _AddValuePageState();
}

class _AddValuePageState extends State<AddValuePage> {
  @override
  void initState() {
    BlocProvider.of<AddValueBloc>(context).add(ResetAddValue());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddValueBloc, AddValueState>(
      listener: (context, state) {},
      child: Container(),
    );
  }
}
