import 'package:flutter/material.dart';
import 'package:appcenter/appcenter.dart';
import 'package:appcenter_analytics/appcenter_analytics.dart';
import 'package:appcenter_crashes/appcenter_crashes.dart';

import 'views/quotes/quotes.dart';
import 'views/account/account.dart';
import 'views/more/more.dart';

void main() {
  final appSecret = '1671ee3c-8c10-4896-b622-30428d4648f2';

  AppCenter.start(appSecret, [AppCenterAnalytics.id, AppCenterCrashes.id]);
  runApp(new TradingApp());
}

class TradingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final accentColor = Colors.blue;

    return MaterialApp(
      title: 'flex',
      theme: ThemeData(
        primaryColor: Colors.black,
        accentColor: accentColor,
        brightness: Brightness.dark,
        toggleableActiveColor: accentColor,
        buttonColor: accentColor
      ),
      initialRoute: '/',
      routes: {
        '/' : (context) => Home()
      },
    );
  }
}


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
 int _selectedIndex = 0;
 List<Widget> _widgetOptions;

 @override
 void initState() {
    _widgetOptions = [
      Quotes(),
      Account(),
      More(),
    ];
    super.initState();
  }

 @override
 Widget build(BuildContext context) {
   return Scaffold(
     body: Center(
       child: _widgetOptions.elementAt(_selectedIndex),
     ),
     bottomNavigationBar: BottomNavigationBar(
       items: <BottomNavigationBarItem>[
         BottomNavigationBarItem(icon: Icon(Icons.equalizer), title: Text('Котировки')),
         BottomNavigationBarItem(icon: Icon(Icons.business_center), title: Text('Портфель')),
         BottomNavigationBarItem(icon: Icon(Icons.menu), title: Text('Ещё')),
       ],
       currentIndex: _selectedIndex,
       onTap: _onItemTapped,
     ),
   );
 }

 void _onItemTapped(int index) {
   setState(() {
     _selectedIndex = index;
   });
 }
}