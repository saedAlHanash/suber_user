import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../strings/app_color_manager.dart';

class SpinnerWidget<T> extends StatelessWidget {
  const SpinnerWidget({
    Key? key,
    required this.items,
    this.hint,
    this.onChanged,
    this.customButton,
    this.width,
    this.dropdownWidth,
    this.sedFirstItem,
    this.expanded,
    this.decoration,
  }) : super(key: key);

  final List<SpinnerItem> items;
  final Widget? hint;
  final Widget? customButton;
  final Function(SpinnerItem item)? onChanged;
  final double? width;
  final double? dropdownWidth;
  final bool? sedFirstItem;
  final bool? expanded;
  final BoxDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    SpinnerItem? selectedItem;

    final list = items.map(
      (item) {
        if (item.isSelected) selectedItem = item;

        final padding = (item.icon == null)
            ? const EdgeInsets.symmetric(horizontal: 15.0).w
            : EdgeInsets.only(left: 15.0.w);
        return DropdownMenuItem(
          value: item,
          child: DrawableText(
            text: item.name ?? '',
            padding: padding,
            color: (item.id >= 0) ? Colors.black : AppColorManager.gray.withOpacity(0.7),
            fontFamily: FontManager.cairoBold,
            drawableStart: item.icon,
            drawablePadding: 15.0.w,
          ),
        );
      },
    ).toList();

    if (hint == null) selectedItem ??= items[0];

    if ((sedFirstItem ?? false) && selectedItem != null) {
      if (onChanged != null) onChanged!(selectedItem!);
    }

    return StatefulBuilder(
      builder: (_, state) {
        return DropdownButton2<SpinnerItem>(
          items: list,
          value: selectedItem,
          hint: hint,
          onChanged: (value) {
            if (value!.id < 0) return;

            onChanged?.call(value);
            state(() => selectedItem = value);
          },
          buttonWidth: width,
          isExpanded: expanded ?? false,
          dropdownWidth: dropdownWidth,
          customButton: customButton,
          underline: 0.0.verticalSpace,
          buttonHeight: 60.0.h,
          dropdownMaxHeight: 300.0.h,
          buttonDecoration: decoration ??
              BoxDecoration(
                borderRadius: BorderRadius.circular(12.0.r),
                color: AppColorManager.f1.withOpacity(0.5),
              ),
          buttonPadding: EdgeInsets.zero,
          buttonElevation: 0,
          dropdownElevation: 2,
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
        );
      },
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
//             fontFamily: FontManager.cairoBold,
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
