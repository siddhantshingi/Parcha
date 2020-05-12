import 'package:flutter/material.dart';

class TabNavigator extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final WidgetBuilder topWidget;

  TabNavigator({Key key, this.navigatorKey, this.topWidget}) : super(key: key);

  @override
  TabNavigatorState createState() => TabNavigatorState();
}

class TabNavigatorState extends State<TabNavigator> {
  void push<T>(BuildContext context, {@required T payload}) {
    print('TabNavigator.push() called');
    Widget nextScreen = payload as Widget;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => nextScreen,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
        key: widget.navigatorKey,
        onGenerateRoute: (routeSettings) {
          // Handle Named Routes to Login Screen
          if (routeSettings.name == '/login')
            Navigator.pushReplacementNamed(context, routeSettings.name);

          print('Check ' + routeSettings.toString());
          return MaterialPageRoute(builder: widget.topWidget);
        });
  }
}
