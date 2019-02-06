import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController controller;

  SearchTextField({this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        isDense: true,
        filled: true,
        fillColor: Colors.white12,
        hintText: 'Наименование или ISIN',
        suffixIcon: Icon(Icons.search),
        border: OutlineInputBorder()
      )
    );
  }
}