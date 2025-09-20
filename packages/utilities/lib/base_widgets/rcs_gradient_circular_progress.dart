import 'dart:math';

import 'package:flutter/material.dart';
import 'package:utilities/base_widgets/rcs_text_widget.dart';
import 'package:utilities/strings.dart';
import 'package:utilities/text_size.dart';
import 'package:utilities/utils.dart';

import '../app_colors.dart';

class RcsCircularProgressIndicator extends StatefulWidget {
  RcsCircularProgressIndicator(
      {super.key,
      this.progress = 0,
      this.color = AppColors.progressGreenColor,
        this.radius,this.strokeWidth,this.textSize=25
      });

  @override
  State<RcsCircularProgressIndicator> createState() =>
      _RcsCircularProgressIndicatorState();

  final int progress;
  final Color color;
  final double? radius;
  final double? strokeWidth;
  final int textSize;

  Widget progressValue(bool isPortrait, int progress) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        RcsText(
          "$progress",
          size: TextSize.setSp(textSize),
          fontWeight: FontWeight.w900,
        ),
        RcsText(
          Strings.loginPercentageSymbolText,
          fontWeight: FontWeight.w500,
          size: TextSize.setSp(textSize)/1.8,
        ),
      ],
    );
  }
}

class _RcsCircularProgressIndicatorState
    extends State<RcsCircularProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animationController.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isPortrait = Utils.orientation == Orientation.portrait;
    return PopScope(
      canPop: false,
      child: Stack(
        alignment: Alignment.center,
        children: [
          RotationTransition(
            turns: Tween(begin: 0.0, end: 1.0).animate(_animationController),
            child: GradientCircularProgressIndicator(
              radius: widget.radius ?? Space.sp(55),
              gradientColors:  [
                AppColors.white,
                widget.color,
              ],
              strokeWidth: widget.strokeWidth ?? Space.sp(20),
              progress: widget.progress,
            ),
          ),
          widget.progressValue(isPortrait, widget.progress)
        ],
      ),
    );
  }
}

class GradientCircularProgressIndicator extends StatelessWidget {
  final double radius;
  final List<Color> gradientColors;
  final double strokeWidth;
  final int progress;

  const GradientCircularProgressIndicator(
      {super.key,
      required this.radius,
      required this.gradientColors,
      this.strokeWidth = 10.0,
      required this.progress});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.fromRadius(radius),
      painter: GradientCircularProgressPainter(
          radius: radius,
          gradientColors: gradientColors,
          strokeWidth: strokeWidth,
          progress: progress),
    );
  }
}

class GradientCircularProgressPainter extends CustomPainter {
  GradientCircularProgressPainter(
      {required this.radius,
      required this.gradientColors,
      required this.strokeWidth,
      required this.progress});

  final double radius;
  final List<Color> gradientColors;
  final double strokeWidth;
  final int progress;

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Offset.zero & size;

    var paint = Paint()
      ..color = AppColors.white
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    double halfStrokeWidth = strokeWidth / 2;
    rect = Rect.fromLTWH(
      halfStrokeWidth,
      halfStrokeWidth,
      size.width - strokeWidth,
      size.height - strokeWidth,
    );

    paint.shader = SweepGradient(
      colors: gradientColors,
      startAngle: 0.1,
      endAngle: pi,
      tileMode: TileMode.clamp,
    ).createShader(rect);

    canvas.drawArc(rect, pi * 0.1,
        2 * pi * (processProgressionValue(progress) / 100), false, paint);
  }

  int processProgressionValue(int progress) {
    return (progress < 30)
        ? 30
        : (progress > 90)
            ? 90
            : progress;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
