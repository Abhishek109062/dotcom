import 'package:dot_com/components/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget locationBox(String asset, String text) {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.primarySecondThemeColor),
      borderRadius: BorderRadius.circular(10),
      color: AppColors.primaryThemeColor,
    ),
    child: Column(
      children: [
        SvgPicture.asset(asset),
        SizedBox(
          height: 8,
        ),
        Text('${text}'),
      ],
    ),
  );
}
