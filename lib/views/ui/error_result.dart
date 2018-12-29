import 'package:flutter/material.dart';

class ErrorResult extends StatelessWidget {
  final VoidCallback onRetry;

  ErrorResult({@required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Упс. Что то пошло не так', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Padding(padding: EdgeInsets.only(top: 20)),
        RaisedButton(
          child: Text('ПОВТОРИТЬ'),
          onPressed: onRetry,
        )
      ]
    );
  }
}