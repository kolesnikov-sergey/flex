import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class AccountDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(),
          title: Text('Портфель'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Cirlce(),
              House(),
            ],
          ),
        )
      );
  }
}

class Cirlce extends StatefulWidget {
  @override
  _CirlceState createState() => _CirlceState();
}

class _CirlceState extends State<Cirlce> with SingleTickerProviderStateMixin {
  double percentage = 0;
  double newPercentage = 10;

  late AnimationController percentageAnimationController;
  late Timer timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(Duration(seconds: 1), (t) {
      _upValue(1);
    });

    percentageAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500)
    )
          ..addListener(_animate)
          ..forward(from: 0);
  }

  @override
  void dispose() {
    timer.cancel();
    percentageAnimationController.dispose();
    super.dispose();
  }

  void _animate() {
    setState(() {
      percentage = lerpDouble(
          percentage, newPercentage, percentageAnimationController.value) ?? 0;
    });
  }

  void _up() {
    _upValue(10);
  }

  void _upValue(int value) {
    setState(() {
      newPercentage += value;
      if (newPercentage >= 100) {
        newPercentage = 0;
      }
      percentageAnimationController.forward(from: 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CirclePainter(completePercent: percentage),
      child: Container(
        height: 200,
        width: 200,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: RaisedButton(
            color: Colors.indigo,
            shape: CircleBorder(),
            child: Text(percentage.toStringAsFixed(2)),
            onPressed: _up,
          ),
        ),
      ),
    );
  }
}

class _CirclePainter extends CustomPainter {
  double completePercent;

  _CirclePainter({ required this.completePercent });

  @override
  void paint(Canvas canvas, Size size) {
    final line = Paint()
      ..color = Colors.amber
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    final complete = Paint()
      ..color = Colors.blueAccent
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = max(size.width / 2, size.height / 2);

    canvas.drawCircle(center, radius, line);

    final arcAngle = 2 * pi * completePercent / 100;

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        arcAngle, false, complete);
  }

  @override
  bool shouldRepaint(_CirclePainter oldDelegate) {
    return completePercent != oldDelegate.completePercent;
  }
}

class House extends StatefulWidget {
  @override
  _HouseState createState() => _HouseState();
}

class _HouseState extends State<House> with SingleTickerProviderStateMixin {
  double houseInit = 0;

  late AnimationController houseAnimationController;

  @override
  void initState() {
    super.initState();

    houseAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 2000))
          ..addListener(_animate);

    houseAnimationController.forward();
  }

  @override
  void dispose() {
    houseAnimationController.dispose();
    super.dispose();
  }

  void _animate() {
    setState(() {
      houseInit = houseAnimationController.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(200, 200),
      painter: _HousePainter(init: houseInit),
    );
  }
}

class _HousePainter extends CustomPainter {
  double init;

  _HousePainter({ required this.init });

  @override
  void paint(Canvas canvas, Size size) {
    final line = Paint()
      ..color = Colors.pink
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    final start = Offset(0, size.height / 4);
    final downLeft = Offset(0, size.height);
    final downRight = Offset(size.width, size.height);
    final unRight = Offset(size.width, size.height / 4);
    final top = Offset(size.width / 2, 0);

    canvas.drawLine(start, downLeft, line);

    if (init > 0.2) {
      canvas.drawLine(downLeft, downRight, line);
    }

    if (init > 0.4) {
      canvas.drawLine(downRight, unRight, line);
    }

    if (init > 0.6) {
      canvas.drawLine(unRight, start, line);
    }

    if (init > 0.8) {
      canvas.drawLine(start, top, line);
      canvas.drawLine(unRight, top, line);
    }
  }

  @override
  bool shouldRepaint(_HousePainter oldDelegate) {
    return init != oldDelegate.init;
  }
}
