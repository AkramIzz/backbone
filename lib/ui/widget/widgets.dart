import 'package:flutter/material.dart';

import 'layout.dart';
import '../style/colors.dart';

part 'buttons.dart';
part 'inputs.dart';
part 'animations.dart';

class InfoCard extends StatelessWidget {
  InfoCard(this.title, this.info, {Key key}) : super(key: key);

  final String title;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
        color: AppColors.accent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              textScaleFactor: 0.8,
              style: TextStyle(color: AppColors.primary),
            ),
            Text(
              info,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ));
  }
}

class DottedColumnChild extends StatelessWidget {
  DottedColumnChild(
      {@required this.child,
      this.color = AppColors.primary,
      this.lineColorUp,
      this.lineColorDown,
      this.verticalPadding = 12.0,
      this.isFirst = false,
      this.isLast = false,
      this.isFilled,
      this.lineVerticalPadding = 0,
      this.dotRadius = 6.0,
      this.drawDot = true,
      Key key})
      : super(key: key);

  final Widget child;
  final Color color, lineColorUp, lineColorDown;
  final double verticalPadding;
  final bool isFirst, isLast;
  final bool isFilled;
  final double lineVerticalPadding;
  final double dotRadius;
  final bool drawDot;

  @override
  Widget build(BuildContext context) {
    return SizedLayoutBuilder(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: verticalPadding),
        child: child,
      ),
      builder: (context, size, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            CustomPaint(
              size: Size(24, size.height),
              painter: LineWithADotPainter(
                  color: color,
                  lineColorUp: lineColorUp,
                  lineColorDown: lineColorDown,
                  isFirst: isFirst,
                  isLast: isLast,
                  isFilled: isFilled,
                  lineVerticalPadding: lineVerticalPadding,
                  dotVerticalPadding: verticalPadding,
                  dotRadius: dotRadius,
                  drawDot: drawDot),
            ),
            Expanded(child: child),
          ],
        );
      },
    );
  }
}

class LineWithADotPainter extends CustomPainter {
  LineWithADotPainter(
      {@required this.color,
      this.lineColorUp,
      this.lineColorDown,
      this.isFirst = false,
      this.isLast = false,
      this.isFilled,
      this.lineVerticalPadding = 0,
      this.dotVerticalPadding = 0,
      this.dotRadius = 6.0,
      this.drawDot})
      : assert(
            ((isFirst == true || isLast == true) &&
                    lineColorUp == null &&
                    lineColorDown == null) ||
                (isFirst == false && isLast == false),
            'lineColorUp and lineColorDown properties can\'t be used with first or last child');

  final Color color, lineColorUp, lineColorDown;
  final bool isFirst;
  final bool isLast;
  final bool isFilled;
  final double lineVerticalPadding;
  final double dotVerticalPadding;
  final double dotRadius;
  final bool drawDot;

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidthToDotSizeRatio = 0.3125;
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidthToDotSizeRatio * dotRadius;
    if (isFilled == null) {
      paint.style = isFirst ? PaintingStyle.stroke : PaintingStyle.fill;
    } else {
      paint.style = isFilled ? PaintingStyle.fill : PaintingStyle.fill;
    }

    double dotVerticalPosition = size.height / 2;
    if (isFirst) {
      dotVerticalPosition = 0 + dotVerticalPadding + dotRadius * 2;
    } else if (isLast) {
      dotVerticalPosition = size.height - dotVerticalPadding - dotRadius * 2;
    }

    final dotCenter = Offset(dotRadius, dotVerticalPosition);
    final lineStart = isFirst
        ? dotCenter.translate(0, dotRadius + lineVerticalPadding)
        : Offset(dotRadius, 0);
    final lineEnd = isLast
        ? dotCenter.translate(0, -(dotRadius + lineVerticalPadding))
        : Offset(dotRadius, size.height);

    if (drawDot) {
      canvas.drawCircle(dotCenter, dotRadius, paint);
    }

    final _lineColorUp = lineColorUp ?? color;
    final _lineColorDown = lineColorDown ?? color;
    if (lineColorUp == null && lineColorDown == null) {
      canvas.drawLine(lineStart, lineEnd, paint);
    } else if (_lineColorDown == _lineColorUp) {
      paint.color = _lineColorUp;
      canvas.drawLine(lineStart, lineEnd, paint);
      // reset color
      paint.color = color;
    } else {
      canvas.drawLine(
          lineStart,
          dotCenter.translate(0, -(dotRadius + lineVerticalPadding)),
          paint..color = _lineColorUp);
      canvas.drawLine(dotCenter.translate(0, dotRadius + lineVerticalPadding),
          lineEnd, paint..color = _lineColorDown);
      // reset color
      paint.color = color;
    }
  }

  @override
  bool shouldRepaint(LineWithADotPainter old) => true;
}
