import 'package:flutter/material.dart';

import '../account/account.dart';
import '../quotes/quotes_view.dart';
import '../security/security_view.dart';
import '../more/more.dart';

class MobileLayout extends StatefulWidget {
  @override
  _MobileLayoutState createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions;

  @override
  void initState() {
    _widgetOptions = [
      QuotesView(
        onPressed: (security, type) {
          Navigator.push(context, new MaterialPageRoute(
            builder: (BuildContext context) => SecurityView(
              security: security,
              securityType: type,
            ),
          ));
        }
      ),
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