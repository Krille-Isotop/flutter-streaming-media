import 'package:flutter/material.dart';

enum TabItem { red, blue }

Map<TabItem, String> tabName = {
  TabItem.red: 'Red',
  TabItem.blue: 'Blue',
};

Map<TabItem, IconData> tabIcon = {
  TabItem.red: Icons.home,
  TabItem.blue: Icons.person,
};


class BottomNavigation extends StatelessWidget {
  BottomNavigation({this.currentTab, this.onSelectTab});

  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        _buildItem(tabItem: TabItem.red),
        _buildItem(tabItem: TabItem.blue),
      ],
      onTap: (index) => onSelectTab(
        TabItem.values[index],
      ),
    );
  }

  BottomNavigationBarItem _buildItem({TabItem tabItem}) {
    return BottomNavigationBarItem(
      icon: Icon(
        tabIcon[tabItem],
        color: _colorTabMatching(item: tabItem),
      ),
      title: Text(
        tabName[tabItem],
        style: TextStyle(
          color: _colorTabMatching(item: tabItem),
        ),
      ),
    );
  }

  Color _colorTabMatching({TabItem item}) {
    return currentTab == item ? Colors.black87 : Colors.grey;
  }
}
