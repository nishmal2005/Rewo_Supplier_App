// ignore_for_file: library_private_types_in_public_api

import 'dart:math' as math;

import 'package:flutter/material.dart';

class CircularProgress extends StatefulWidget {
  const CircularProgress(
      {super.key,
      required this.isPauseed,this.widget,
      required this.size,
      this.secondaryColor = Colors.white,
      this.primaryColor = Colors.orange,
      this.lapDuration = 1000,
      this.strokeWidth = 5.0,
      required this.speed});
// 2
  final bool isPauseed;
  final bool speed;
  final double size;
  final Color secondaryColor;
  final Color primaryColor;
  final int lapDuration;
  final double strokeWidth;
  final Widget? widget;

  @override
  _CircularProgress createState() => _CircularProgress();
}

// 3
class _CircularProgress extends State<CircularProgress>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation? animation;

  @override
  void initState() {
    super.initState();
// 2
    controller = AnimationController(
        animationBehavior: AnimationBehavior.preserve,
        vsync: this,
        duration: widget.speed
            ? const Duration(milliseconds: 500)
            : const Duration(seconds: 30))
      ..repeat();
    animation = Tween<double>(begin: 0.0, end: 360.0).animate(controller!)
      ..addListener(() {
        setState(() {});
      });
  }

// 3
  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
// 4
    return RotationTransition(
      turns: Tween(
        begin: 0.0,
        end: widget.isPauseed ? 0.0 : 1.0,
      ).animate(controller!),
      child: CustomPaint(
        painter: CirclePaint(
            secondaryColor: widget.secondaryColor,
            primaryColor: widget.primaryColor,
            strokeWidth: widget.strokeWidth),
        size: Size(widget.size, widget.size),
      ),
    );
  }
}

class CirclePaint extends CustomPainter {
  final Color secondaryColor;
  final Color primaryColor;
  final double strokeWidth;

  // 2
  double _degreeToRad(double degree) => degree * math.pi / 180;

  CirclePaint(
      {this.secondaryColor = Colors.grey,
      this.primaryColor = Colors.blue,
      this.strokeWidth = 15});
  @override
  void paint(Canvas canvas, Size size) {
    double centerPoint = size.height / 2;

    Paint paint = Paint()
      ..color = primaryColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    paint.shader = SweepGradient(
      colors: [secondaryColor, primaryColor],
      tileMode: TileMode.repeated,
      startAngle: _degreeToRad(270),
      endAngle: _degreeToRad(270 + 360.0),
    ).createShader(
        Rect.fromCircle(center: Offset(centerPoint, centerPoint), radius: 0));
// 1
    var scapSize = strokeWidth * 0.70;
    double scapToDegree = scapSize / centerPoint;
// 2
    double startAngle = _degreeToRad(270) + scapToDegree;
    double sweepAngle = _degreeToRad(360) - (2 * scapToDegree);

    canvas.drawArc(const Offset(0.0, 0.0) & Size(size.width, size.width),
        startAngle, sweepAngle, false, paint..color = primaryColor);
  }

  @override
  bool shouldRepaint(CirclePaint oldDelegate) {
    return true;
  }
}
