import 'package:flutter/cupertino.dart';
import '../ui_widgets/cupertino_home_scaffold.dart';
import '../ui_widgets/tab_item.dart';
import '../model/user_list.dart';
import 'account/account_page.dart';
import 'home/home_page.dart';
import 'lists/list_view_page.dart';
import 'maps/maps_page.dart';


class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

// Keeps track of which tab we are on
class _NavigationPageState extends State<NavigationPage> {
  TabItem _currentTab = TabItem.home;
  UserList? selectedListForMap;

  @override
  void initState() {
    super.initState();
    selectedListForMap = UserList(
        id: 'testList_1', title: 'My Test List 1', category: 'testing');
  }

  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.map: GlobalKey<NavigatorState>(),
    TabItem.list: GlobalKey<NavigatorState>(),
    TabItem.home: GlobalKey<NavigatorState>(),
    TabItem.account: GlobalKey<NavigatorState>(),
  };

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      //Takes a context argument, but passing _ since we don't need it.
      TabItem.map: (_) => SafeArea(
            child: MapPage(userList: selectedListForMap),
          ),
      TabItem.list: (_) => ListViewPage(
            onUserListSelected: _onUserListSelected,
            displayAddButton: true,
          ),
      TabItem.home: (_) => HomePage(
            onUserListSelected: _onUserListSelected,
          ),
      TabItem.account: (_) => const AccountPage(),
    };
  }

  void _onUserListSelected(UserList userList) {
    setState(() {
      selectedListForMap = userList;
    });
    _select(TabItem.map);
  }

  void _select(TabItem tabItem) {
    if (tabItem == _currentTab) {
      navigatorKeys[tabItem]?.currentState?.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = tabItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Used for handling back navigation on Android.
        // Pops the stack one at a time until it exits the app on the last pop.
        final currentState = navigatorKeys[_currentTab]?.currentState;
        if (currentState != null && currentState.canPop()) {
          currentState.pop();
          return false; // Prevents the app from closing
        } else {
          return true; // Allow the app to close
        }
      },
      child: CupertinoHomeScaffold(
          navigatorKeys: navigatorKeys,
          widgetBuilders: widgetBuilders,
          currentTab: _currentTab,
          onSelectTab: _select),
    ); //Callback. Rebuilds the HomePage when tab selected
  }
}
