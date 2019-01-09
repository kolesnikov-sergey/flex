import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'error_result.dart';

class FlexFutureBuilder<T> extends StatelessWidget {
  final Future<T> future;
  final AsyncWidgetBuilder<T> builder;
  final VoidCallback onRetry;

  FlexFutureBuilder({
    this.future,
    @required this.builder,
    @required this.onRetry
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Center(
              child: Theme.of(context).platform == TargetPlatform.iOS
                ? CupertinoActivityIndicator()
                : CircularProgressIndicator()
            );
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Center(
                child: ErrorResult(onRetry: onRetry)
              );
            }
               
            return builder(context, snapshot);
        }
        return null;
      },
    );
  }
}