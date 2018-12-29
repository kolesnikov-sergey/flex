import 'package:flutter/material.dart';

class Option extends StatelessWidget {
  final String text;
  final IconData icon;
  final Widget trailing;

  Option({@required this.text, @required this.icon, this.trailing});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).primaryColor),
      title: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold
        )
      ),
      trailing: trailing,
    );
  }
}