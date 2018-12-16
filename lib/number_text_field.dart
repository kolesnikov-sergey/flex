import 'package:flutter/material.dart';

class NumberTextField extends StatelessWidget {
  final String label;
  final String placeholder;
  final String initialValue;
  TextEditingController controller;

  NumberTextField({this.label, this.placeholder, this.initialValue, this.controller}) {
    if(controller == null) {
      controller = new TextEditingController(text: initialValue);
    }
  }

  down() => change(-1);

  up() => change(1);

  change(change) {
    final value = controller.text;
    final valueParsed = num.tryParse(value);
    if(valueParsed != null) {
      controller.text = (valueParsed  + change).toString();
    }
    else {
      controller.text = '0';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: placeholder,
          prefixIcon: IconButton(
            icon: Icon(Icons.remove_circle_outline),
            onPressed: down,
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.add_circle_outline),
            onPressed: up,
          ),
          border: OutlineInputBorder(),
        )
      )
    );
  }
}