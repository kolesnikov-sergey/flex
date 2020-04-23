import 'package:flutter/material.dart';

class AddOrderButton extends StatelessWidget {
  final VoidCallback onPressed;

  AddOrderButton({@required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: SafeArea(
        child: MaterialButton(
          minWidth: double.infinity,
          child: Text('ЗАЯВКА'),
          color: Theme.of(context).accentColor,
          onPressed: onPressed,
        )
      )
    );
  }
}
