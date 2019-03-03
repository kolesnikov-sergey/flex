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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Cirlce(),
          House(),
        ],
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
  AnimationController percentageAnimationController;

  @override
  void initState() {
    super.initState();

    percentageAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500)
    )
    ..addListener(_animate);

    percentageAnimationController.forward();
  }

  @override
  void dispose() {
    percentageAnimationController.dispose();
    super.dispose();
  }

  void _animate() {
    setState(() {
      percentage = lerpDouble(percentage, newPercentage, percentageAnimationController.value);
    });
  }

  void _up() {
    setState(() {
      newPercentage += 10;
      if(newPercentage >= 100) {
        newPercentage = 0;
      }
      percentageAnimationController.forward(from: 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 200.0,
        width: 200.0,
        child: CustomPaint(
          foregroundPainter: _CirclePainter(
            completePercent: percentage
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: RaisedButton(
              color: Colors.indigo,
              shape: CircleBorder(),
              child: Text("Click"),
              onPressed: _up,
            ),
          ),
        )
      )
    );
  }
}

class _CirclePainter extends CustomPainter {
  double completePercent;

  _CirclePainter({this.completePercent});

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

    final center  = Offset((size.width / 2), size.height / 2);
    final radius  = max(size.width / 2, size.height / 2);

    canvas.drawCircle(
      center,
      radius,
      line
    );

    final arcAngle = 2 * pi * ((completePercent) / 100);

    canvas.drawArc(
      Rect.fromCircle(center: center,radius: radius),
      -pi / 2,
      arcAngle,
      false,
      complete
    );
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

  AnimationController houseAnimationController;

  @override
  void initState() {
    super.initState();

    houseAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000)
    )
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
    return Container(
      height: 200,
      width: 200,
      child: CustomPaint(
        foregroundPainter: _HousePainter(
          init: houseInit
        ),
      )
    );
  }
}

class _HousePainter extends CustomPainter {
  double init;

  _HousePainter({this.init});

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

    if(init > 0.2) {
      canvas.drawLine(downLeft, downRight, line);
    }

    if(init > 0.4) {
      canvas.drawLine(downRight, unRight, line);
    }

    if(init > 0.6) {
      canvas.drawLine(unRight, start, line);
    }
    
    if(init > 0.8) {
      canvas.drawLine(start, top, line);
      canvas.drawLine(unRight, top, line);
    }    
  }

  @override
  bool shouldRepaint(_HousePainter oldDelegate) {
    return init != oldDelegate.init;
  }
}