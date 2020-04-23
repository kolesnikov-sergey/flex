import 'dart:async';

Function throttle(int delayMs, Function fn) {
  Timer timer;

  return () {
    if (timer != null) {
      return;
    }
    timer = Timer(Duration(milliseconds: delayMs), () {
      timer = null;
      fn();
    });
  };
}