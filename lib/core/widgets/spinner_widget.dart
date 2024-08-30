import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../strings/app_color_manager.dart';
import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpinnerWidget<T> extends StatefulWidget {
  const SpinnerWidget({
    super.key,
    required this.items,
    this.hint,
    this.hintText,
    this.onChanged,
    this.customButton,
    this.width,
    this.dropdownWidth,
    this.sendFirstItem,
    this.expanded,
    this.isOverButton,
    this.decoration,
  }) ;

  final List<SpinnerItem> items;
  final Widget? hint;
  final String? hintText;
  final Widget? customButton;
  final Function(SpinnerItem spinnerItem)? onChanged;
  final double? width;
  final double? dropdownWidth;
  final bool? sendFirstItem;
  final bool? expanded;
  final bool? isOverButton;
  final BoxDecoration? decoration;

  @override
  State<SpinnerWidget<T>> createState() => SpinnerWidgetState<T>();
}

class SpinnerWidgetState<T> extends State<SpinnerWidget<T>> {
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (_, state) {
        return Column(
          children: [
            Row(
              children: [
                SizedBox( height: .8.h, width: .04.sw),
                3.0.horizontalSpace,
                DrawableText(
                  text: widget.hintText ?? '',
                  color: AppColorManager.gray,
                  size: 14.0.sp,
                  fontFamily: FontManager.cairo.name,
                ),
                3.0.horizontalSpace,
                Expanded(
                  child: Container(height: .8.h),
                )
              ],
            ),
            DropdownButton2(
              items: widget.items.map(
                    (item) {
                  return DropdownMenuItem(
                    value: item,
                    child: DrawableText(
                      selectable: false,
                      text: item.name ?? '',
                      padding: const EdgeInsets.symmetric(horizontal: 10.0).w,
                      color: (item.enable)
                          ? item.isSelected
                          ? AppColorManager.gray
                          : Colors.black
                          : AppColorManager.gray.withOpacity(0.7),
                      drawableStart: item.icon,
                      drawablePadding: item.icon != null ? 15.0.w : null,
                    ),
                  );
                },
              ).toList(),
              value: widget.items.firstWhereOrNull((e) => e.isSelected),
              hint: widget.hint,
              onChanged: (value) {
                if (widget.onChanged != null) widget.onChanged!(value!);
                setState(() {
                  if (!(value!).enable) return;
                  for (var e in widget.items) {
                    e.isSelected = false;
                    if (e.id == value.id) e.isSelected = true;
                  }
                });
              },
              buttonStyleData: ButtonStyleData(
                width: widget.width,
                height: 40.0.h,
                decoration: widget.decoration ?? const BoxDecoration(),
                elevation: 0,
              ),
              dropdownStyleData: DropdownStyleData(
                width: widget.dropdownWidth,
                maxHeight: 300.0.h,
                elevation: 2,
                isOverButton: widget.isOverButton ?? false,
              ),
              iconStyleData: IconStyleData(
                icon: Row(
                  children: [
                    const Icon(
                      Icons.expand_more,
                      color: AppColorManager.mainColor,
                    ),
                    18.0.horizontalSpace,
                  ],
                ),
                iconSize: 35.0.spMin,
              ),
              isExpanded: widget.expanded ?? false,
              customButton: widget.customButton,
              underline: 0.0.verticalSpace,
            ),
            Container(color: AppColorManager.mainColor, height: 1.0.h, width: 1.0.sw),
          ],
        );
      },
    );
  }
}

class SpinnerOutlineTitle extends StatelessWidget {
  const SpinnerOutlineTitle({
    super.key,
    required this.items,
    this.hint,
    this.onChanged,
    this.customButton,
    this.width,
    this.dropdownWidth,
    this.sendFirstItem,
    this.expanded,
    this.decoration,
    this.label = '',
  });

  final List<SpinnerItem> items;
  final Widget? hint;
  final Widget? customButton;
  final Function(SpinnerItem spinnerItem)? onChanged;
  final double? width;
  final double? dropdownWidth;
  final bool? sendFirstItem;
  final bool? expanded;
  final BoxDecoration? decoration;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DrawableText(
          selectable: false,
          text: label,
          color: AppColorManager.black,
          padding: const EdgeInsets.symmetric(horizontal: 10.0).w,
          size: 18.0.sp,
        ),
        3.0.verticalSpace,
        SpinnerWidget(
          items: items,
          hint: hint,
          onChanged: onChanged,
          customButton: customButton,
          width: width,
          dropdownWidth: dropdownWidth,
          sendFirstItem: sendFirstItem,
          expanded: expanded,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0.r),
            border: Border.all(color: AppColorManager.gray, width: 1.0.r),
          ),
        )
      ],
    );
  }
}

class SpinnerItem {
  SpinnerItem({
    this.name,
    this.id = -2,
    this.isSelected = false,
    this.item,
    this.icon,
    this.enable = true,
  });

  String? name;
  int id;
  bool isSelected;
  bool enable;
  dynamic item;
  Widget? icon;

//<editor-fold desc="Data Methods">

  SpinnerItem copyWith({
    String? name,
    int? id,
    bool? isSelected,
    bool? enable,
    dynamic item,
  }) {
    return SpinnerItem(
      name: name ?? this.name,
      id: id ?? this.id,
      isSelected: isSelected ?? this.isSelected,
      enable: enable ?? this.enable,
      item: item ?? this.item,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'isSelected': isSelected,
      'enable': enable,
      'item': item,
    };
  }

  factory SpinnerItem.fromMap(Map<String, dynamic> map) {
    return SpinnerItem(
      name: map['name'] as String,
      id: map['id'] as int,
      isSelected: map['isSelected'] as bool,
      enable: map['enable'] as bool,
      item: map['item'] as dynamic,
    );
  }

//</editor-fold>
}


// class SpinnerListWidget<T> extends StatelessWidget {
//   const SpinnerListWidget({
//     Key? key,
//     required this.items,
//     this.hint,
//     this.onChanged,
//     this.customButton,
//     this.width,
//     this.dropdownWidth,
//     this.sedFirstItem,
//     this.expanded,
//     this.decoration,
//   }) : super(key: key);
//
//   final List<SpinnerItem> items;
//   final Widget? hint;
//   final Widget? customButton;
//   final Function(SpinnerItem item)? onChanged;
//   final double? width;
//   final double? dropdownWidth;
//   final bool? sedFirstItem;
//   final bool? expanded;
//   final BoxDecoration? decoration;
//
//   @override
//   Widget build(BuildContext context) {
//     SpinnerItem? selectedItem;
//
//     final list = items.map(
//       (item) {
//         if (item.isSelected) selectedItem = item;
//
//         final padding = (item.icon == null)
//             ? const EdgeInsets.symmetric(horizontal: 15.0).w
//             : EdgeInsets.only(left: 15.0.w);
//         return DropdownMenuItem(
//           value: item,
//           child: DrawableText(
//             text: item.name ?? '',
//             padding: padding,
//             color: (item.id != 0) ? Colors.black : AppColorManager.gray.withOpacity(0.7),
//             fontFamily: FontManager.cairoBold.name,
//             drawableStart: item.icon,
//             drawablePadding: 15.0.w,
//           ),
//         );
//       },
//     ).toList();
//
//     // selectedItem ??= items.firstItem();
//
//     if ((sedFirstItem ?? false) && selectedItem != null) {
//       if (onChanged != null) onChanged!(selectedItem!);
//     }
//
//     return StatefulBuilder(
//       builder: (_, state) {
//         return DropdownButton2(
//           items: list,
//           value: selectedItem,
//           hint: hint,
//           onChanged: (value) {
//             if (onChanged != null) onChanged!(value!);
//             state(() => selectedItem = value!);
//           },
//           buttonWidth: width,
//           isExpanded: expanded ?? false,
//           dropdownWidth: dropdownWidth,
//           customButton: customButton,
//           underline: 0.0.verticalSpace,
//           buttonHeight: 60.0.h,
//           dropdownMaxHeight: 300.0.h,
//           buttonDecoration: decoration ??
//               BoxDecoration(
//                 borderRadius: BorderRadius.circular(12.0.r),
//                 color: AppColorManager.f1.withOpacity(0.5),
//               ),
//           buttonPadding: EdgeInsets.zero,
//           buttonElevation: 0,
//           dropdownElevation: 2,
//           icon: const Icon(
//             Icons.arrow_drop_down_outlined,
//             color: AppColorManager.mainColor,
//           ),
//           iconSize: 44.0.spMin,
//         );
//       },
//     );
//   }
// }
