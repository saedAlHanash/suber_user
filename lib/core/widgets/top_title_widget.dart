import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:qr_mobile_vision_example/core/strings/app_color_manager.dart';
import 'package:qr_mobile_vision_example/core/widgets/my_card_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'images/image_multi_type.dart';

class TopTitleWidget extends StatelessWidget {
  const TopTitleWidget({
    Key? key,
    required this.text,
    required this.icon,
    this.iconSize,
    this.safeArea,
  }) : super(key: key);

  final String text;
  final String icon;
  final double? iconSize;

  final bool? safeArea;

  @override
  Widget build(BuildContext context) {
    final iconSize = this.iconSize ?? 30.0.spMin;

    final iconWidget = ImageMultiType(
      url: icon,
      height: iconSize,
      width: iconSize,
      color: AppColorManager.mainColor,
    );

    final textWidget = DrawableText(
      text: text,
      color: AppColorManager.gray,
      fontFamily: FontManager.cairoBold,
      size: 16.0.sp,
    );
    return MyCardWidget(
      margin: EdgeInsets.symmetric(
        horizontal: 35.0.w,
        vertical: (safeArea ?? false) ? 40.0.h : 5.0.h,
      ),
      padding: EdgeInsets.symmetric(vertical: 12.0.h, horizontal: 14.0.w),
      elevation: 3.0,
      cardColor: AppColorManager.lightGray,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [iconSize.horizontalSpace, textWidget, iconWidget],
      ),
    );
  }
}
