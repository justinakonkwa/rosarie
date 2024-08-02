import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rosary App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentBead = 1;
  double _beadRotation = 0; // For bead rotation animation

  void _nextBead() {
    setState(() {
      if (_currentBead < 53) {
        _currentBead++;
        _beadRotation += 0.1; // Update rotation for next bead
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rosary App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Realistic rosary with chain and crucifix
            Transform.rotate(
              angle: _beadRotation,
              child: Stack(
                children: [
                  // Chain
                  CustomPaint(
                    painter: ChainPainter(),
                    size: Size(200, 300),
                  ),
                  // Beads
                  for (double i = 1; i <= 53; i++)
                    BeadWidget(
                      beadNumber: i.toInt(),
                      isCurrent: i.toInt() == _currentBead,
                      size: _getBeadSize(i.toInt()),
                    ),
                  // Crucifix
                  Positioned(
                    top: 100,
                    left: 50,
                    child: CrucifixWidget(),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            // Next button
            ElevatedButton(
              onPressed: _nextBead,
              child: Text('Next bead'),
            ),
          ],
        ),
      ),
    );
  }

  double _getBeadSize(int beadNumber) {
    if (beadNumber % 10 == 1) {
      return 16.0; // Larger size for "Our Father" beads
    } else {
      return 12.0; // Smaller size for "Hail Mary" beads
    }
  }
}

// Custom painter for chain
class ChainPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.grey..strokeWidth = 2;
    final path = Path();

    for (int i = 0; i < size.height; i += 10) {
      path.moveTo(0, i.toDouble());
      path.lineTo(size.width, i.toDouble());
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true; // Repaint for animation
  }
}

// Widget for individual beads
class BeadWidget extends StatelessWidget {
  final int beadNumber;
  final bool isCurrent;
  final double size;

  BeadWidget({
    required this.beadNumber,
    required this.isCurrent,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    final color = isCurrent ? Colors.blue : Colors.grey;
    final offset = Offset(
      beadNumber % 6 * size,
      (beadNumber ~/ 6) * size,
    );

    return Transform.translate(
      offset: offset,
      child: CustomPaint(
        painter: BeadPainter(color: color, size: size),
      ),
    );
  }
}

// Custom painter for beads
class BeadPainter extends CustomPainter {
  final Color color;
  final double size;

  BeadPainter({required this.color, required this.size});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;

    // Draw the bead with a gradient fill to simulate texture
    final gradient = RadialGradient(
      colors: [color.withOpacity(0.7), color],
      radius: size.width / 2,
    );

    canvas.drawCircle(Offset(size.width / 2, size.height / 2), size.width / 2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

// Custom painter for crucifix
class CrucifixWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(50, 100),
      painter: CrucifixPainter(),
    );
  }
}

class CrucifixPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    // Draw the cross
    paint.color = Colors.black;
    paint.strokeWidth = 5;
    canvas.drawLine(
      Offset(size.width / 2, 0),
      Offset(size.width / 2, size.height),
      paint,
    );
    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      paint,
    );

    // Draw the corpus (Jesus figure)
    paint.color = Colors.brown;
    final corpusSize = size.height * 0.6;
    final corpusOffset = Offset(size.width / 2 - corpusSize / 2, size.height / 2 - corpusSize / 2);
    canvas.drawRect(Rect.fromCenter(center: corpusOffset, width: corpusSize, height: corpusSize), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
