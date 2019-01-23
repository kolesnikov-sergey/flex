import 'package:flutter/material.dart';

class FlexDropdown<T> extends StatelessWidget {
  final T initialValue;
  final Map<T, String> items;
  final PopupMenuItemSelected<T> onSelected;

  FlexDropdown({@required this.initialValue, @required this.items, @required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      initialValue: initialValue,
      child: Row(
        mainAxisAlignment: Theme.of(context).platform == TargetPlatform.iOS
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
        children: [
          Text(items[initialValue]),
          Icon(Icons.arrow_drop_down)
        ],
      ),
      onSelected: (val) {
        onSelected(val);
      },
      itemBuilder: (context) => items.entries
        .map((entry) => PopupMenuItem(
          value: entry.key,
          child: Text(entry.value),
        ))
        .toList(),
    );
  }
}
 