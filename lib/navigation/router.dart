import 'package:flutter/material.dart';
import 'package:flutter_navigation_guide/navigation/route_generator.dart';
import 'bottom_navigation.dart';

class Router extends StatefulWidget {
  @override
  _RouterState createState() => _RouterState();
}

class _RouterState extends State<Router> {
  TabItem currentTab = TabItem.red;

  Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.red: GlobalKey<NavigatorState>(),
    TabItem.blue: GlobalKey<NavigatorState>(),
  };

  void _selectTab(TabItem tabItem) {
    setState(() {
      currentTab = tabItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !await navigatorKeys[currentTab].currentState.maybePop(),
          child: Scaffold(
        body: Stack(children: <Widget>[
          _buildOffstageNavigator(TabItem.red, initalRoute: RouteGenerator.red),
          _buildOffstageNavigator(TabItem.blue,
              initalRoute: RouteGenerator.blue)
        ]),
        bottomNavigationBar: BottomNavigation(
          currentTab: currentTab,
          onSelectTab: _selectTab,
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(TabItem tabItem, {String initalRoute}) {
    return Offstage(
      offstage: currentTab != tabItem,
      child: Navigator(
        key: navigatorKeys[tabItem],
        initialRoute: initalRoute,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
