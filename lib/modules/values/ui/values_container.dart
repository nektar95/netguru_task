import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguru_task/modules/home/bloc/bloc.dart';
import 'package:netguru_task/modules/values/models/value.dart';

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
        Center(
            child: Text(
          widget.values[index].text,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontFamily: 'Catamaran',
              fontWeight: FontWeight.w600,
              fontSize: 36),
        )),
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
