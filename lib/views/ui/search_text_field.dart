import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController controller;

  SearchTextField({this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      scrollPadding: EdgeInsets.all(10),
      decoration: const InputDecoration(
        isDense: true,
        hintText: 'Поиск',
        suffixIcon: Icon(Icons.search),
        border: OutlineInputBorder()
      )
    );
  }
}