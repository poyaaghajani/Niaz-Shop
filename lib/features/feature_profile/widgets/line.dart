import 'package:flutter/material.dart';

class Line extends StatelessWidget {
  final double width;
  const Line(this.width, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.grey.shade200,
            Colors.grey.shade400,
            Colors.grey.shade600,
            Colors.grey.shade600,
            Colors.grey.shade600,
            Colors.grey.shade400,
            Colors.grey.shade200,
          ],
        ),
      ),
    );
  }
}
