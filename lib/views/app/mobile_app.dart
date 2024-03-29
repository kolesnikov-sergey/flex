import 'package:flutter/material.dart';

import '../account/account.dart';
import '../quotes/quotes_view.dart';
import '../more/more.dart';

class MobileApp extends StatefulWidget {
  @override
  _MobileAppState createState() => _MobileAppState();
}

class _MobileAppState extends State<MobileApp> {
  int _selectedIndex = 0;
  late List<Widget> _widgetOptions;

  @override
  void initState() {
    _widgetOptions = [
      QuotesView(),
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
          BottomNavigationBarItem(icon: Icon(Icons.equalizer), label: 'Котировки'),
          BottomNavigationBarItem(icon: Icon(Icons.business_center), label: 'Портфель'),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Ещё'),
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