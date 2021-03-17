import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguru_task/base/ui/base_button.dart';
import 'package:netguru_task/l10n/l10n.dart';
import 'package:netguru_task/modules/add_value/bloc/bloc.dart';

class AddValueInput extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              maxLines: 2,
              controller: valueController,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).accentColor,
                  fontSize: 20),
              keyboardType: TextInputType.text,
              onFieldSubmitted: (_) {
                BlocProvider.of<AddValueBloc>(context)
                    .add(AddNewValue(valueController.value.text));
              },
              validator: (value) {
                if (value.length > 250) {
                  return AppLocalizations.of(context).addNewValueInputValidate;
                }
                return null;
              },
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor)),
                border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor)),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor)),
                disabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor)),
                hintStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).accentColor,
                    fontSize: 20),
                hintText: AppLocalizations.of(context).addNewValueInputHint,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: BaseButton(
                AppLocalizations.of(context).addNewValueButton,
                width: MediaQuery.of(context).size.width,
                onPressed: () {
                  BlocProvider.of<AddValueBloc>(context)
                      .add(AddNewValue(valueController.value.text));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
