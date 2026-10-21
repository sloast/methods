import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:methods/core/method.dart';

class MethodDiagram extends StatefulWidget {
  const MethodDiagram({super.key, required this.parsedMethod});

  final ParsedMethod parsedMethod;

  @override
  State<StatefulWidget> createState() => MethodDiagramState();
}

class MethodDiagramState extends State<MethodDiagram>
    with SingleTickerProviderStateMixin {
  static const List<Tab> tabs = [Tab(text: "Line"), Tab(text: "Grid")];

  late TabController _tabController;

  double scale = 1;
  double scaleOffset = 1;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final parsedMethod = widget.parsedMethod;
    final grid = _tabController.index == 1;
    final course = grid
        ? parsedMethod.rows.toList()
        : parsedMethod.plainCourse.toList();
    final huntBells = parsedMethod.huntBells;
    final insideBells = grid
        ? parsedMethod.insideBells
        : [parsedMethod.stage - 1];

    return Column(
      children: [
        TabBar(
          controller: _tabController,
          onTap: (_) {
            setState(() {});
          },
          tabs: tabs,
        ),
        Expanded(
          child: ListView(
            padding: .all(20),
            children: [
              GestureDetector(
                onScaleStart: (d) {
                  scaleOffset = scale - 1;
                },
                onScaleUpdate: (d) {
                  setState(() {
                    scale = clampDouble(
                      d.verticalScale + scaleOffset,
                      0.2,
                      1.0,
                    );
                  });
                },
                onScaleEnd: (d) {},
                onDoubleTap: () {
                  setState(() {
                    scale = scale > 0.8 ? 0.25 : 1.0;
                  });
                },
                child: Center(
                  child: DiagramContainer(
                    method: course,
                    huntBells: huntBells,
                    insideBells: insideBells,
                    leadLength: parsedMethod.length,
                    drawNums: true,
                    scale: scale,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DiagramContainer extends StatelessWidget {
  const DiagramContainer({
    super.key,
    required this.method,
    required this.huntBells,
    required this.insideBells,
    required this.leadLength,
    this.drawNums = true,
    this.drawLeadEnds = true,
    this.hideTreble = false,
    this.scale = 1.0,
  });

  final List<List<int>> method;
  final List<int> huntBells;
  final List<int> insideBells;
  final int leadLength;
  final bool drawNums;
  final bool drawLeadEnds;
  final bool hideTreble;
  final double scale;

  @override
  Widget build(BuildContext context) {
    final stage = method.isNotEmpty ? method[0].length : 2;

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 30.0 * stage),
      child: AspectRatio(
        aspectRatio: method.isNotEmpty ? stage / method.length / scale : 1,
        child: CustomPaint(
          painter: MethodPainter(
            method: method,
            huntBells: huntBells,
            insideBells: insideBells,
            leadLength: leadLength,
            drawNums: drawNums,
            drawLeadEnds: drawLeadEnds,
            hideTreble: hideTreble,
            alpha: scale,
            colorScheme: Theme.of(context).colorScheme,
          ),
        ),
      ),
    );
  }
}

class MethodPainter extends CustomPainter {
  const MethodPainter({
    required this.method,
    required this.huntBells,
    required this.insideBells,
    required this.leadLength,
    required this.drawNums,
    required this.drawLeadEnds,
    required this.hideTreble,
    required this.alpha,
    required this.colorScheme,
  });

  final List<List<int>> method;
  final List<int> huntBells;
  final List<int> insideBells;
  final int leadLength;
  final bool drawNums;
  final bool drawLeadEnds;
  final bool hideTreble;
  final double alpha;
  final ColorScheme colorScheme;

  @override
  void paint(Canvas canvas, Size size) {
    if (method.isEmpty || method[0].isEmpty) return;
    final stage = method[0].length;

    final xinc = size.width / stage;
    final yinc = size.height / method.length;
    final xstart = xinc / 2;
    final ystart = yinc / 2;

    final scale = min(xinc, yinc);

    final paint = Paint()
      ..color = Colors.grey.shade800
      ..style = .stroke
      ..strokeCap = .round
      ..strokeWidth = max(scale / 15, 1)
      ..strokeJoin = .miter
      ..strokeMiterLimit = xstart;

    final path = Path();

    if (!drawNums) {
      // vertical guide lines
      for (int i = 0; i < stage; i++) {
        final double x = xstart + xinc * i;
        path.moveTo(x, ystart);
        path.lineTo(x, ystart + yinc * (method.length - 1));
        canvas.drawPath(path, paint);
        path.reset();
      }
    } else if (alpha > 0.5) {
      const chars = '1234567890ETABCD';

      final textPainter = TextPainter(textDirection: .ltr);
      final textStyle = TextStyle(
        color:
            Color.lerp(
              Colors.transparent,
              colorScheme.onSurface,
              alpha * 2 - 1,
            ) ??
            colorScheme.onSurface,
        fontSize: scale * 0.75,
        fontWeight: .w400,
      );
      for (int n = 0; n < stage; n++) {
        if (huntBells.contains(n) || insideBells.contains(n)) {
          continue;
        }
        for (final (i, r) in method.indexed) {
          final e = r.indexOf(n);
          if (i == -1) continue;

          textPainter.text = TextSpan(text: chars[n], style: textStyle);

          final x = xstart + xinc * e;
          final y = ystart + yinc * i;

          textPainter.layout();
          textPainter.paint(
            canvas,
            .new(x - textPainter.width / 2, y - textPainter.height / 2),
          );
        }
      }
    }

    // horizontal lines at lead end
    if (drawLeadEnds && leadLength > 0) {
      paint.color =
          Color.lerp(Colors.transparent, colorScheme.onSurface, alpha) ??
          colorScheme.onSurface;
      for (int i = leadLength; i < method.length - 1; i += leadLength) {
        final y = yinc * i;
        path.moveTo(0, y);
        path.lineTo(size.width, y);
        canvas.drawPath(path, paint);
        path.reset();
      }
    }

    void drawBlueline(int n, [bool isHuntBell = false]) {
      double y = ystart - yinc;
      bool first = true;
      bool active = false;
      for (final row in method) {
        y += yinc;
        var inx = row.indexOf(n);
        final x = xstart + xinc * inx;

        if (inx == -1) {
          canvas.drawPath(path, paint);
          path.reset();
          first = true;
          continue;
        }

        if ((isHuntBell &&
            hideTreble &&
            !((inx > 0 && insideBells.contains(row[inx - 1])) ||
                (inx + 1 < row.length &&
                    insideBells.contains(row[inx + 1]))))) {
          first = false;
          if (active) {
            path.lineTo(x, y);
            canvas.drawPath(path, paint);
            active = false;
          }
          path.reset();
          path.moveTo(x, y);

          continue;
        }

        active = true;

        if (first) {
          path.moveTo(x, y);
          first = false;
        }
        path.lineTo(x, y);
      }

      canvas.drawPath(path, paint);
      path.reset();
    }

    for (final (i, n) in huntBells.indexed) {
      final hue = 360 - (i / huntBells.length) * 80;
      paint.color = HSVColor.fromAHSV(1, hue, 1, 1).toColor();
      drawBlueline(n, true);
    }

    final colors = [
      Colors.blue,
      Colors.green,
      Colors.amber,
      Colors.orange.shade700,
      Colors.deepPurpleAccent,
      Colors.teal,
      Colors.cyan.shade200,
      Colors.yellow,
      Colors.lightGreen.shade300,
      Colors.brown,
      Colors.green.shade900,
      Colors.purple,
      Colors.red,
      Colors.indigo,
      Colors.lime,
      Colors.deepOrange,
    ];

    paint.strokeWidth = max(scale / 5, 2);
    for (final (i, n) in insideBells.indexed) {
      paint.color = colors[i];
      drawBlueline(n);
    }
  }

  @override
  bool shouldRepaint(MethodPainter oldDelegate) {
    return oldDelegate.method != method ||
        oldDelegate.huntBells != huntBells ||
        oldDelegate.insideBells != insideBells ||
        oldDelegate.leadLength != leadLength ||
        oldDelegate.drawNums != drawNums ||
        oldDelegate.alpha != alpha;
  }
}
