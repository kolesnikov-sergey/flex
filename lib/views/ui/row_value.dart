import 'package:flutter/cupertino.dart';

class RowValue extends StatelessWidget {
  final String label;
  final Widget value;

  RowValue({@required this.label, @required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        value
      ]
    );
  }
}