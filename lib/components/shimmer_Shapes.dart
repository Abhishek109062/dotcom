import 'package:flutter/material.dart';

class ShimmerShapes extends StatelessWidget {
  final double? height, width;
  double defaultPadding;
  double defaultBorderRadius;
  Widget child = SizedBox();
  ShimmerShapes.rectangular(
      {Key? key,
      this.height,
      this.width,
      this.defaultPadding = 0.0,
      this.defaultBorderRadius = 0.0,
      this.child = const SizedBox()})
      : super(key: key);

  ShimmerShapes.circular(
      {this.height,
      this.width,
      this.defaultPadding = 0.0,
      this.defaultBorderRadius = 50});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.all(defaultPadding / 2),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          borderRadius: BorderRadius.all(Radius.circular(defaultBorderRadius))),
      child: child,
    );
  }
}
