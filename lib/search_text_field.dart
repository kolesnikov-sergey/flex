import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController controller;

  SearchTextField({this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        hintText: 'Название или ISIN',
        suffixIcon: Icon(Icons.search),
        border: OutlineInputBorder()
      )
    );
  }
}