import 'package:flutter/material.dart';

class BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width * 0.0008000, size.height * 0.0020500);
    path.quadraticBezierTo(size.width * 0.0110000, size.height * 0.2018000,
        size.width * 0.0244000, size.height * 0.2498000);
    path.cubicTo(
        size.width * 0.0302000,
        size.height * 0.2905000,
        size.width * 0.1042000,
        size.height * 0.3148000,
        size.width * 0.0990000,
        size.height * 0.3522500);
    path.cubicTo(
        size.width * 0.1001000,
        size.height * 0.4772500,
        size.width * 0.1400000,
        size.height * 0.5947000,
        size.width * 0.1075000,
        size.height * 0.6556500);
    path.cubicTo(
        size.width * 0.1045000,
        size.height * 0.6893000,
        size.width * 0.0339000,
        size.height * 0.7226500,
        size.width * 0.0296000,
        size.height * 0.7542000);
    path.quadraticBezierTo(size.width * 0.0111000, size.height * 0.7938500,
        size.width * 0.0008000, size.height * 1.0020500);
    path.lineTo(size.width, size.height);
    path.quadraticBezierTo(size.width * 0.9946000, size.height * 0.7905500,
        size.width * 0.9742000, size.height * 0.7528000);
    path.cubicTo(
        size.width * 0.9720000,
        size.height * 0.7264000,
        size.width * 0.9038000,
        size.height * 0.6878000,
        size.width * 0.8829000,
        size.height * 0.6540000);
    path.cubicTo(
        size.width * 0.8646000,
        size.height * 0.6298000,
        size.width * 0.8938000,
        size.height * 0.4797500,
        size.width * 0.8935000,
        size.height * 0.3541500);
    path.cubicTo(
        size.width * 0.8933000,
        size.height * 0.3178000,
        size.width * 0.9704000,
        size.height * 0.2945500,
        size.width * 0.9754000,
        size.height * 0.2519000);
    path.quadraticBezierTo(size.width * 0.9856000, size.height * 0.2167000,
        size.width * 0.9966000, size.height * 0.0029500);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
