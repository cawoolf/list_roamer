import 'package:flutter/material.dart';

enum TabItem {map , list, home, account}

class TabItemData {
  const TabItemData({required this.label, required this.icon});

  final String label;
  final IconData icon;

  static const Map<TabItem, TabItemData> allTabs = {
    TabItem.map: TabItemData(label: 'Map', icon: Icons.map),
    TabItem.list: TabItemData(label: 'List', icon: Icons.list),
    TabItem.home: TabItemData(label: 'Home', icon: Icons.home),
    TabItem.account: TabItemData(label: 'Account', icon: Icons.person),
  };


}