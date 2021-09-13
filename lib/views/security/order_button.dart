import 'package:flutter/material.dart';

class OrderButton extends StatelessWidget {
  final bool fullWidth;
  final VoidCallback onPressed;

  OrderButton({
    this.fullWidth = false,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: SafeArea(
        child: MaterialButton(
          minWidth: fullWidth ? double.infinity : null,
          height: 40,
          child: Text('ЗАЯВКА'),
          color: Theme.of(context).accentColor,
          onPressed: onPressed,
        )
      )
    );
  }
}
