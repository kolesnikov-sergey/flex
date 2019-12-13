import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final ValueChanged<String> onChanged;

  SearchTextField({@required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: const InputDecoration(
        isDense: true,
        hintText: 'Поиск',
        suffixIcon: Icon(Icons.search),
        border: OutlineInputBorder()
      )
    );
  }
}