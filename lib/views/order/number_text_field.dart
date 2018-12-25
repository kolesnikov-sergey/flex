import 'package:flutter/material.dart';

class NumberTextField extends StatefulWidget {
  final String label;
  final String placeholder;
  final String suffixText;
  final double initialValue;
  final double step;
  final int decimals;
  final ValueChanged<double> onSave;
  final FormFieldValidator<String> validator;

  NumberTextField({
    this.label,
    this.placeholder,
    this.suffixText,
    this.initialValue,
    this.step = 1,
    this.decimals = 0,
    this.onSave,
    this.validator
  });

  @override
  _NumberTextFieldState createState() => _NumberTextFieldState();
}

class _NumberTextFieldState extends State<NumberTextField> {
  TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController(text: widget.initialValue?.toStringAsFixed(widget.decimals));
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  down() => change(-(widget.step));

  up() => change(widget.step);

  change(change) {
    final valueParsed = double.tryParse(controller.text);
    if(valueParsed != null) {
      controller.text = (valueParsed + change).toStringAsFixed(widget.decimals);
    }
    else {
      controller.text = '0';
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onSaved: (value) {
        if(widget.onSave != null) {
          widget.onSave(double.tryParse(value));
        }
      },
      autocorrect: true,
      validator: widget.validator,
      keyboardType: TextInputType.numberWithOptions(
        decimal: widget.decimals > 0
      ),
      decoration: InputDecoration(
        isDense: true,
        suffixText: widget.suffixText,
        labelText: widget.label,
        hintText: widget.placeholder,
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
    );
  }
}
