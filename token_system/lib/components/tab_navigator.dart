import 'package:flutter/material.dart';

class TabNavigator extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final Widget topWidget;

  TabNavigator({Key key, this.navigatorKey, this.topWidget}) : super(key: key);

  @override
  TabNavigatorState createState() => TabNavigatorState();
}

class TabNavigatorState extends State<TabNavigator> {
  Widget _nextScreen;

  void push(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _nextScreen,
      ),
    );
  }

  void updateScreen(Widget newScreen) {
    _nextScreen = newScreen;
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
        key: widget.navigatorKey,
        onGenerateRoute: (routeSettings) {
          print('Check' + routeSettings.toString());
          return MaterialPageRoute(builder: (context) => widget.topWidget);
        });
  }
}
