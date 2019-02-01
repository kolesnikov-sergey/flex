import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';

import 'views/quotes/quotes.dart';
import 'views/account/account.dart';
import 'views/more/more.dart';

void main() {
  runApp(new TradingApp());
}

class TradingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final primaryColor = Color(0xFF1976d2);

    return new DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (brightness) => new ThemeData(
        accentColor: primaryColor,
        brightness: brightness,
        primaryColor: brightness == Brightness.dark ? Colors.black : primaryColor,
        toggleableActiveColor: primaryColor,
        buttonColor: primaryColor,
      ),
      themedWidgetBuilder: (context, theme) {
        return MaterialApp(
          title: 'flex',
          theme: theme,
          initialRoute: '/',
          routes: {
            '/' : (context) => Home()
          },
        );
      }
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