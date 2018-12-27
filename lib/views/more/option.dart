import 'package:flutter/material.dart';

class Option extends StatelessWidget {
  final String text;
  final IconData icon;

  Option({@required this.text, @required this.icon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.indigo,),
      title: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold
        )
      ),
    );
  }
}