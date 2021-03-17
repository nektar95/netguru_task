import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguru_task/base/models/error_code.dart';
import 'package:netguru_task/base/ui/failure_widget.dart';
import 'package:netguru_task/base/ui/loading_widget.dart';
import 'package:netguru_task/base/utils.dart';
import 'package:netguru_task/l10n/l10n.dart';
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
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeErrorState) {
          var message = AppLocalizations.of(context).unknownException;

          switch (state.errorCode) {
            case ErrorCode.unexpected:
              message = AppLocalizations.of(context).unknownException;
              break;
            case ErrorCode.storageError:
              message = AppLocalizations.of(context).storageException;
              break;
          }

          setState(() {
            showToast(message, context);
          });
        }
      },
      builder: (context, state) {
        if (state is HomeErrorState) {
          return FailureWidget();
        } else if (state is HomeLoadedState) {
          return ValuesContainer(
            values: state.values,
          );
        }
        return LoadingWidget();
      },
    );
  }
}
