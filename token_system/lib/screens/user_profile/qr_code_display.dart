import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeScreen extends StatefulWidget {
  final String message;
  QrCodeScreen({Key key, @required this.message}) : super(key: key);
  @override
  _QrCodeScreenState createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  @override
  Widget build(BuildContext context) {
    //TODO: Add button to save to gallery
    return Material(
      color: Colors.white,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: Text("Take a screeenshot of the image"),
          centerTitle: true,
          elevation: 0,
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Center(
                  child: Container(
                    width: 380,
                    child: CustomPaint(
                      size: Size.square(380.0),
                      painter: QrPainter(
                        data: widget.message,
                        version: QrVersions.auto,
                        color: Color(0xff1a5441),
                        emptyColor: Color(0xffeafcf6),
                        // size: 320.0,

                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40)
                    .copyWith(bottom: 40),
                child: Text(widget.message.split("\n")[0]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}