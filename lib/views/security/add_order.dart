import 'package:flutter/material.dart';

class AddOrder extends StatelessWidget {
  final VoidCallback onPressed;

  AddOrder({@required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: SafeArea(
        child: MaterialButton(
          minWidth: double.infinity,
          child: Text('ЗАЯВКА'),
          color: Theme.of(context).primaryColor,
          onPressed: onPressed,
        )
      )
    );
  }
}
