import 'package:flutter/material.dart';

class ProfileClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double width = size.width;
    double height = size.height;

    final path = Path();

    path.lineTo(0, height - 100);
    path.quadraticBezierTo(
        width * 0.25, height - 180, width * 0.47, height - 100);
    path.quadraticBezierTo(width * 0.77, height + 30, width, height - 100);

    path.lineTo(width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
