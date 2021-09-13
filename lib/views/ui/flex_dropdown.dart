import 'package:flutter/material.dart';

class FlexDropdown<T> extends StatelessWidget {
  final T value;
  final Map<T, String> items;
  final void Function(T) onChanged;

  FlexDropdown({
    required this.value,
    required this.items,
    required this.onChanged
  });

  _handleChanged(T? value) {
    if (value != null) {
      onChanged(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
      value: value,
      style: Theme.of(context).textTheme.headline6,
      underline: Container(height: 0),
      onChanged: _handleChanged,
      items: items.entries.map((entry) {
        return DropdownMenuItem<T>(
          value: entry.key,
          child: Text(entry.value),
        );
      }).toList()
    );
  }
}