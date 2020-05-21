import 'package:flutter/material.dart';
import 'package:token_system/components/loading.dart';
import 'package:token_system/components/async_builder.dart';

class PullRefresh extends StatefulWidget {
  final Function futureFn;
  final dynamic args1;
  final dynamic args2;
  final Function builder;
  final Function onReceiveJson;
  final int size;


  PullRefresh(
      {Key key,
        @required this.futureFn,
        @required this.builder,
        @required this.onReceiveJson,
        this.args1,
        this.args2,
        this.size: 60})
      : super(key: key);

  @override
  _RefreshState createState() => _RefreshState();

}

class _RefreshState extends State<PullRefresh> {
  Future<dynamic> _future;

  @override
  void initState() {
    super.initState();
    if (widget.args1 == null && widget.args2 == null)
      _future = widget.futureFn();
    else if (widget.args2 == null)
      _future = widget.futureFn(widget.args1);
    else
      _future = widget.futureFn(widget.args1, widget.args2);
  }

  Future<void> _getData() async {
    setState(() {
      if (widget.args1 == null && widget.args2 == null)
        _future = widget.futureFn();
      else if (widget.args2 == null)
        _future = widget.futureFn(widget.args1);
      else
        _future = widget.futureFn(widget.args1, widget.args2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: AsyncBuilder(future: _future, builder: widget.builder, onReceiveJson: widget.onReceiveJson),
      onRefresh: _getData,

    );
  }

}