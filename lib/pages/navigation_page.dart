import 'package:flutter/cupertino.dart';
import 'package:list_roamer/pages/maps_page.dart';
import '../model/user_list.dart';
import '../services/database.dart';
import '../services/helpers/tab_item.dart';
import 'account_page.dart';
import 'common_widgets/cupertino_home_scaffold.dart';
import 'home_page.dart';
import 'list_view_page.dart';
import 'package:provider/provider.dart';

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
    selectedListForMap = UserList('testUser', 'testList_1');
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
      TabItem.map: (_) => MapPage(userList: selectedListForMap),
      TabItem.list: (_) => ListViewPage(onUserListSelected: _onUserListSelected,),
      TabItem.home: (_) => const HomePage(),
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
    if(tabItem == _currentTab) {
      //pop to first route
      print('Current Tab: $_currentTab');
      navigatorKeys[tabItem]?.currentState?.popUntil((route) => route.isFirst);
    }
    else {
      setState(() => _currentTab = tabItem);
    }

  }

  @override
  Widget build(BuildContext context) {

    final database = Provider.of<Database>(context, listen: false);


    return WillPopScope(
      onWillPop: () async{
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
