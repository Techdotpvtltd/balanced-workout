import 'package:flutter/material.dart';

class HorizontalPadding extends StatelessWidget {
  const HorizontalPadding({super.key, this.value, this.child});
  final double? value;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: value ?? 29),
      child: child,
    );
  }
}

class VerticalPadding extends StatelessWidget {
  const VerticalPadding({super.key, this.value, this.child});
  final double? value;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: value ?? 29),
      child: child,
    );
  }
}

class CustomPadding extends StatelessWidget {
  const CustomPadding(
      {super.key, this.left, this.right, this.top, this.bottom, this.child});
  final double? left;
  final double? right;
  final double? top;
  final double? bottom;

  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: left ?? 29,
          right: right ?? 29,
          top: top ?? 30,
          bottom: bottom ?? 30),
      child: child,
    );
  }
}
