import 'package:dot_com/components/shimmer_Shapes.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget NetworkImageLoader(
    {required String image,
    required BoxFit fit,
    required double height,
    required double width,
    required Widget errorWidget,
    Widget? loadingBuilder,
    bool useImageDimension = true}) {
  return Image.network(
    image ?? '',
    fit: fit,
    height: height,
    width: width,
    errorBuilder: (_, __, ___) {
      return Container(
        height: useImageDimension ? height : 0,
        width: useImageDimension ? width : 0,
        child: errorWidget,
      );
    },
    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
      if (loadingProgress == null) {
        return child;
      } else {
        return Center(
            child: Shimmer.fromColors(
          child: Container(
            color: Colors.white,
            child: loadingBuilder ??
                ShimmerShapes.circular(
                  width: width,
                  height: height,
                ),
          ),
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.white,
        ));
      }
    },
  );
}
