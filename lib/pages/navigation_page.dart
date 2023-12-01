import 'package:flutter/cupertino.dart';
import 'package:the_spotz/pages/account_page.dart';
import 'package:the_spotz/pages/common_widgets/cupertino_home_scaffold.dart';
import 'package:the_spotz/pages/maps_page.dart';
import '../services/helpers/tab_item.dart';
import 'list_view_page.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

// Keeps track of which tab we are on
class _NavigationPageState extends State<NavigationPage> {
  TabItem _currentTab = TabItem.home;

  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.map: GlobalKey<NavigatorState>(),
    TabItem.home: GlobalKey<NavigatorState>(),
    TabItem.list: GlobalKey<NavigatorState>(),
    TabItem.account: GlobalKey<NavigatorState>(),
  };

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      //Takes a context argument, but passing _ since we don't need it.
      TabItem.map: (_) => const MapPage(),
      TabItem.home: (_) => const NavigationPage(),
      TabItem.list: (_) => const ListViewPage(),
      TabItem.account: (_) => const AccountPage(),
    };
  }

  void _select(TabItem tabItem) {
    if(tabItem == _currentTab) {
      //pop to first route
      navigatorKeys[tabItem]?.currentState?.popUntil((route) => route.isFirst);
    }
    else {
      setState(() => _currentTab = tabItem);
    }

  }

  @override
  Widget build(BuildContext context) {
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
