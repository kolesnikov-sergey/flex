import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final ValueChanged<String> onChanged;

  SearchTextField({this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      scrollPadding: EdgeInsets.all(10),
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