import 'package:flutter/material.dart';
import 'package:timetracker/home/account/account_page.dart';
import 'package:timetracker/home/cuppertino_home_scaffold.dart';
import 'package:timetracker/home/entries/entries_page.dart';
import 'package:timetracker/home/tab_item.dart';

import 'jobs/jobs_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {
  TabItem _currentTab= TabItem.jobs;

  final Map<TabItem,GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.jobs:GlobalKey<NavigatorState>(),
    TabItem.entries:GlobalKey<NavigatorState>(),
    TabItem.account:GlobalKey<NavigatorState>(),
  };
  Map<TabItem,WidgetBuilder> get widgetBuilders{
    return{
      TabItem.jobs:(_) => JobsPage(),
      TabItem.entries:(context)=>EntriesPage.create(context),
      TabItem.account:(_)=>AccountPage(),
    };
  }

  void _select(TabItem tabItem) {
    if(tabItem == _currentTab){
      //pop to first route
      navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);

    }else{
    setState(() => _currentTab = tabItem   );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // this come out of app if there is only one page on navigator ,
      // if there is more than one in navigator then it doesn't
     onWillPop: () async  => !await navigatorKeys[_currentTab].currentState.maybePop(),
      child: CupertinoHomeScaffold(
        currentTab: _currentTab,
        onSelectedTab: _select,
        widgetBuilders: widgetBuilders,
        navigatorKeys: navigatorKeys,
      ),
    );
  }

}
