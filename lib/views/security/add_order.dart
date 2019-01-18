import 'package:flutter/material.dart';

class AddOrder extends StatelessWidget {
  final VoidCallback onPressed;

  AddOrder({@required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 10,
        top: 20
      ),
      child: SafeArea(
        child: MaterialButton(
          minWidth: double.infinity,
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Text('ЗАЯВКА', style: TextStyle(fontSize: 16))
          ),
          color: Theme.of(context).primaryColor,
          textColor: Theme.of(context).primaryTextTheme.button.color,
          onPressed: onPressed,
        )
      )
    );
  }
}
