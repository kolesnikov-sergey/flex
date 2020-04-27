import 'package:flutter/material.dart';

class FlexDropdown<T> extends StatelessWidget {
  final T value;
  final Map<T, String> items;
  final void Function(T) onChanged;

  FlexDropdown({
    @required this.value,
    @required this.items,
    @required this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
      value: value,
      style: Theme.of(context).textTheme.title,
      underline: Container(height: 0),
      onChanged: onChanged,
      items: items.entries.map((entry) {
        return DropdownMenuItem<T>(
          value: entry.key,
          child: Text(entry.value),
        );
      }).toList()
    );
  }
}