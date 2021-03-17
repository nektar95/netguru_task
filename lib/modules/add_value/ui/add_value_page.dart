import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguru_task/base/models/error_code.dart';
import 'package:netguru_task/base/ui/loading_widget.dart';
import 'package:netguru_task/base/utils.dart';
import 'package:netguru_task/l10n/l10n.dart';
import 'package:netguru_task/modules/add_value/bloc/add_value_bloc.dart';
import 'package:netguru_task/modules/add_value/bloc/bloc.dart';
import 'package:netguru_task/modules/add_value/ui/add_value_info.dart';
import 'package:netguru_task/modules/add_value/ui/add_value_input.dart';
import 'package:netguru_task/modules/add_value/ui/add_value_text.dart';

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AddValueInfo(),
        AddValueText(),
        AddValueInput(),
        BlocConsumer<AddValueBloc, AddValueState>(listener: (context, state) {
          if (state is AddValueSavedState) {
            setState(() {
              showToast(AppLocalizations.of(context).savedValue, context);
            });
          } else if (state is AddValueErrorState) {
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
        }, builder: (context, state) {
          if (state is AddValueSavingState) {
            return LoadingWidget();
          }
          return Container();
        }),
      ],
    );
  }
}
