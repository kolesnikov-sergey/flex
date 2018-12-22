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
    return MaterialApp(
      title: 'Торговый терминал',
      theme: ThemeData(
        primaryColor: Colors.indigo,
      ),
      initialRoute: '/',
      routes: {
        '/' : (context) => Home()
      },
    );
  }
}


class Home extends StatefulWidget {
 Home({Key key}) : super(key: key);

 @override
 _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
 int _selectedIndex = 0;
 final _widgetOptions = [
   Quotes(),
   Account(),
   More(),
 ];

 @override
 Widget build(BuildContext context) {
   return Scaffold(
     body: Center(
       child: _widgetOptions.elementAt(_selectedIndex),
     ),
     bottomNavigationBar: BottomNavigationBar(
       items: <BottomNavigationBarItem>[
         BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Котировки')),
         BottomNavigationBarItem(icon: Icon(Icons.business), title: Text('Портфель')),
         BottomNavigationBarItem(icon: Icon(Icons.school), title: Text('Ещё')),
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