import 'package:flutter/material.dart';

class ErrorResult extends StatelessWidget {
  final VoidCallback onRetry;

  ErrorResult({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Упс. Что то пошло не так', style: Theme.of(context).textTheme.headline6),
        Padding(padding: EdgeInsets.only(top: 20)),
        RaisedButton(
          child: Text('ПОВТОРИТЬ'),
          onPressed: onRetry,
        )
      ]
    );
  }
}