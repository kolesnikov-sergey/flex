import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'error_result.dart';

class Loadable<T> extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final bool hasError;
  final VoidCallback onRetry;

  Loadable({
    @required this.child,
    @required this.isLoading,
    @required this.hasError,
    @required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: Theme.of(context).platform == TargetPlatform.iOS
          ? CupertinoActivityIndicator()
          : CircularProgressIndicator()
      ); 
    }

    if (hasError) {
      return Center(
        child: ErrorResult(onRetry: onRetry)
      );
    }

    return child;
  }
}