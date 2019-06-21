import 'package:flutter/material.dart';

class FlexDrawer<T> extends StatelessWidget {
  final String title;
  final Map<T, String> options;
  final T value;
  final ValueChanged<T> onChange;

  FlexDrawer({
    @required this.title,
    @required this.options,
    @required this.value,
    @required this.onChange
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Center(
              child: Text(title, style: Theme.of(context).textTheme.title)
            ),
          ),
          ...options.entries.map((opt) => ListTile(
            selected:  opt.key == value,
            title: Text(opt.value, style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {
              onChange(opt.key);
              Navigator.pop(context);
            },
          ))
        ]
      )
    );
  }
}