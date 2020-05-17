import 'package:flutter/material.dart';
import 'package:token_system/components/loading.dart';

// Arguments
//
// future {Future} : The Async Network request for whose response the
//                   WidgetBuilder must wait.
// builder {Function<dynamic>} : A function which is passed from the Parent
//                   Widget, to run on the return value that onReceiveJson
//                   returns (if any).
// onReceiveJson {Function<dynamic>} : A function, which is to be executed
//                   on the response of the Network request in the future
//                   argument. This function, if provided, must return a
//                   value which must be used by builder.
// size {int} : Size of loading indicator to be used. {Default: 60}

class AsyncBuilder extends StatelessWidget {
  final Future future;
  final Function builder;
  final Function onReceiveJson;
  final int size;

  AsyncBuilder(
      {Key key,
      @required this.future,
      @required this.builder,
      this.onReceiveJson,
      this.size: 60})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (onReceiveJson != null) {
            var returnValue = onReceiveJson(snapshot);
            return this.builder(returnValue);
          } else {
            return this.builder();
          }
        } else {
          return Loading(size: size);
        }
      },
    );
  }
}
