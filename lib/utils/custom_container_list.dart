import 'package:flutter/material.dart';

class CustomListContainer extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;
  final Color color;
  final BorderRadius borderRadius;

  const CustomListContainer({
    Key? key,
    required this.child,
    required this.width,
    required this.height,
    required this.color,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(color: color, borderRadius: borderRadius),
      child: child,
    );
  }
}
