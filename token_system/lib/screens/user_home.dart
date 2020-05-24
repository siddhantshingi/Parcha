import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:token_system/Entities/user.dart';
import 'package:token_system/components/tab_navigator.dart';
import 'package:token_system/screens/booking/choose_category.dart';
import 'package:token_system/screens/user_profile/profile.dart';
import 'package:token_system/screens/user_profile/user_history.dart';

class UserHome extends StatefulWidget {
  final User user;

  UserHome({Key key, @required this.user}) : super(key: key);

  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  int _selectedIndex = 0;
  List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];
  List<GlobalKey<TabNavigatorState>> _tabNavigatorKeys = [
    GlobalKey<TabNavigatorState>(),
    GlobalKey<TabNavigatorState>(),
    GlobalKey<TabNavigatorState>(),
  ];
  List<TabNavigator> _tabNavigators = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _selectTab(int index) {
    if (index == _selectedIndex) {
      // pop to first route
      _navigatorKeys[index].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() => _selectedIndex = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Create a unique TabNavigator for each GlobalKey
    for (var i = 0; i < 3; i++) {
      TabNavigator tn = TabNavigator(
        key: _tabNavigatorKeys[i],
        navigatorKey: _navigatorKeys[i],
        topWidget: _buildBody(i),
      );
      _tabNavigators.add(tn);
    }

    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_selectedIndex].currentState.maybePop();
        if (isFirstRouteInCurrentTab) {
          // if not on the 'main' tab
          if (_selectedIndex != 0) {
            // select 'main' tab
            _selectTab(0);
            // back button handled by app
            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Parcha'),
          backgroundColor: Colors.blueGrey,
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.power_settings_new),
              tooltip: 'Logout',
              onPressed: () async {
                var prefs = await SharedPreferences.getInstance();
                await prefs.remove('signedAs');
                await prefs.remove('entityData');
                Navigator.pushReplacementNamed(context, '/login');
              },
            )
          ],
        ),
        body: Stack(children: <Widget>[
          _buildOffstageNavigator(0),
          _buildOffstageNavigator(1),
          _buildOffstageNavigator(2),
        ]),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.all_out),
              title: Text('Token'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              title: Text('History'),
            ),
          ],
          currentIndex: _selectedIndex,
          unselectedItemColor: Colors.blueGrey,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(int index) {
    return Offstage(
      offstage: _selectedIndex != index,
      child: _tabNavigators[index],
    );
  }

  WidgetBuilder _buildBody(int index) {
    // Returning WidgetBuilder makes it easier to implement callbacks
    if (index == 1) {
      Builder builder = Builder(
        builder: (context) => ChooseCategory(
          user: widget.user,
          tn: _tabNavigatorKeys[1],
        ),
      );
      return builder.builder;
    } else if (index == 2) {
      Builder builder = Builder(
        builder: (context) => UserHistory(
          user: widget.user,
          tn: _tabNavigatorKeys[2],
        ),
      );
      return builder.builder;
    }
    Builder builder = Builder(
      builder: (context) => UserProfile(
        user: widget.user,
        tn: _tabNavigatorKeys[0],
      ),
    );
    return builder.builder;
  }
}
