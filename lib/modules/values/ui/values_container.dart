import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguru_task/modules/home/bloc/bloc.dart';
import 'package:netguru_task/modules/values/models/value.dart';
import 'package:netguru_task/modules/values/ui/value_text.dart';

class ValuesContainer extends StatefulWidget {
  const ValuesContainer({Key key, this.values}) : super(key: key);

  final List<Value> values;

  @override
  _ValuesContainerState createState() => _ValuesContainerState();
}

class _ValuesContainerState extends State<ValuesContainer> {
  int index = 0;
  Timer timer;
  final rng = Random();

  @override
  void dispose() {
    if (timer != null) {
      timer.cancel();
    }
    super.dispose();
  }

  @override
  void initState() {
    index = rng.nextInt(widget.values.length);
    if (timer == null || !timer.isActive) {
      timer = Timer.periodic(const Duration(seconds: 5), (timer) {
        setState(() {
          index = rng.nextInt(widget.values.length);
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(child: ValueText(text: widget.values[index].text)),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FloatingActionButton(
                child: widget.values[index].favorite
                    ? Icon(Icons.favorite)
                    : Icon(Icons.favorite_border),
                backgroundColor: widget.values[index].favorite
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).primaryColorLight,
                onPressed: () {
                  setState(() {
                    BlocProvider.of<HomeBloc>(context)
                        .add(AddValueToFavorites(widget.values[index].id));
                  });
                }),
          ),
        )
      ],
    );
  }
}
