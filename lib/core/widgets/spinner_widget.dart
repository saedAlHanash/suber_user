import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../strings/app_color_manager.dart';
import '../util/my_style.dart';
import 'my_text_form_widget.dart';

class SpinnerWidget<T> extends StatefulWidget {
  const SpinnerWidget({
    super.key,
    required this.items,
    this.hint,
    this.hintText,
    this.onChangedMultiSelect,
    this.hintLabel,
    this.onChanged,
    this.customButton,
    this.width,
    this.dropdownWidth,
    this.sendFirstItem,
    this.expanded,
    this.isOverButton,
    this.decoration,
    this.loading = false,
    this.multiSelect = false,
    this.searchable = true,
    this.icon,
    this.isRequired = false,
  });

  final List<SpinnerItem> items;
  final Widget? hint;
  final dynamic icon;
  final String? hintText;
  final String? hintLabel;
  final Widget? customButton;
  final Function(SpinnerItem spinnerItem)? onChanged;
  final Function(List<SpinnerItem> selected)? onChangedMultiSelect;
  final double? width;
  final double? dropdownWidth;
  final bool? sendFirstItem;
  final bool? expanded;
  final bool? isOverButton;
  final bool loading;
  final bool multiSelect;
  final bool searchable;
  final BoxDecoration? decoration;
  final bool isRequired;

  @override
  State<SpinnerWidget<T>> createState() => SpinnerWidgetState<T>();
}

class SpinnerWidgetState<T> extends State<SpinnerWidget<T>> {
  final textEditingController = TextEditingController();

  List<DropdownMenuItem<SpinnerItem>>? get getItems {
    final list = widget.items.map(
          (item) {
        if (widget.multiSelect) {
          return DropdownMenuItem(
            value: item,
            enabled: false,
            child: StatefulBuilder(
              builder: (context, menuSetState) {
                return InkWell(
                  onTap: () {
                    setState(
                            () => menuSetState(() => item.isSelected = !item.isSelected));

                    widget.onChangedMultiSelect
                        ?.call(widget.items.where((e) => e.isSelected).toList());
                  },
                  child: Container(
                    height: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        if (item.isSelected)
                          const Icon(
                            Icons.check_box_outlined,
                            color: AppColorManager.mainColor,
                          )
                        else
                          const Icon(Icons.check_box_outline_blank),
                        5.0.horizontalSpace,
                        Expanded(
                          child: DrawableText(text: item.name ?? '-'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
        return DropdownMenuItem(
          value: item,
          enabled: item.enable,
          child: DrawableText(
            selectable: false,
            size: 13.0.sp,
            text: item.name ?? '',
            color: (item.temp || !item.enable) ? Colors.grey : Colors.black,
            drawableStart: item.icon == null
                ? null
                : ImageMultiType(
              url: item.icon,
              color: Colors.grey,
              height: 17.0.r,
              width: 17.0.r,
            ),
            drawablePadding: 5.0.w,
          ),
        );
      },
    ).toList();
    // if (widget.multiSelect) {
    //   list.add(
    //     DropdownMenuItem(
    //       value: SpinnerItem(id: 'done'),
    //       enabled: false,
    //       child: TextButton(
    //         style: ButtonStyle(
    //           backgroundColor: WidgetStatePropertyAll(
    //             AppColorManager.mainColor.withOpacity(0.1),
    //           ),
    //         ),
    //         onPressed: () {
    //           context.pop();
    //         },
    //         child: Center(
    //           child: DrawableText(
    //             text: S.of(context).done,
    //             color: AppColorManager.mainColor,
    //             textAlign: TextAlign.center,
    //             drawableAlin: DrawableAlin.withText,
    //             drawableStart: const ImageMultiType(url: Icons.done),
    //           ),
    //         ),
    //       ),
    //     ),
    //   );
    // }
    return list;
  }

  Widget get hintLabel {
    return DrawableText(
      text: widget.hintLabel ?? '',
      color: AppColorManager.black,
      size: 12.0.sp,
      matchParent: true,
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0).r,
      drawableEnd: widget.isRequired
          ? DrawableText(
        text: ' * ',
        color: Colors.red,
        drawablePadding: 5.0.w,
      )
          : null,
    );
  }

  Widget? get hint {
    return (widget.hintText != null)
        ? DrawableText(
      text: widget.hintText!,
      fontWeight: FontWeight.w500,
      color: Colors.grey[400],
      size: 12.0.sp,
    )
        : widget.hint;
  }

  Widget get iconOrLoading {
    return Row(
      children: [
        if (widget.loading)
          SizedBox(
            height: 25.0.r,
            width: 25.0.r,
            child: MyStyle.loadingWidget(),
          )
        else if (widget.icon != null)
          widget.icon is Widget
              ? widget.icon
              : ImageMultiType(
            url: widget.icon,
            height: 24.0.r,
            width: 24.0.r,
          ),
        if (widget.icon != null) 12.0.horizontalSpace,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.hintLabel != null) hintLabel,
        Container(
          decoration: widget.decoration ??
              BoxDecoration(
                color: AppColorManager.f1,
                borderRadius: BorderRadius.all(Radius.circular(10.0.r)),
              ),
          padding: const EdgeInsets.symmetric(horizontal: 10.0).r,
          child: Column(
            children: [
              Row(
                children: [
                  iconOrLoading,
                  Expanded(
                    child: DropdownButton2(
                      items: getItems,
                      value: widget.multiSelect
                          ? null
                          : widget.items.firstWhereOrNull((e) => e.isSelected),
                      hint: hint,
                      onChanged: (value) {
                        if (widget.loading) return;
                        if (widget.onChanged != null) widget.onChanged!(value!);
                        if (value!.temp) {
                          for (final e in widget.items) {
                            e.isSelected = false;
                          }
                          setState(() {});
                          return;
                        }
                        if (!(value).enable) return;
                        for (final e in widget.items) {
                          e.isSelected = false;
                          if (e.id == value.id) {
                            e.isSelected = true;
                          }
                        }
                        setState(() {});
                      },
                      buttonStyleData: buttonStyleData,
                      menuItemStyleData: menuItemStyleData,
                      dropdownStyleData: dropdownStyleData,
                      iconStyleData: iconStyleData,
                      isExpanded: widget.expanded ?? true,
                      customButton: widget.customButton,
                      underline: 0.0.verticalSpace,
                      dropdownSearchData: dropdownSearchData,
                      onMenuStateChange: onMenuStateChange,
                    ),
                  ),
                ],
              ),
              if (widget.multiSelect) multiSelectList,
            ],
          ),
        ),
      ],
    );
  }

  Widget get multiSelectList {
    return Builder(builder: (context) {
      final list = widget.items.where((e) => e.isSelected).toList();
      if (list.isEmpty) return 0.0.verticalSpace;
      return Container(
        padding: const EdgeInsets.only(top: 10.0).h,
        height: 40.0.h,
        width: 1.0.sw,
        child: ListView.separated(
          separatorBuilder: (context, index) => 5.0.horizontalSpace,
          scrollDirection: Axis.horizontal,
          itemCount: list.length,
          itemBuilder: (context, i) {
            final item = list[i];
            return InkWell(
              onTap: () {
                setState(() {
                  widget.items
                      .firstWhere(
                        (e) => e.id == item.id,
                  )
                      .isSelected = false;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColorManager.mainColor,
                  borderRadius: BorderRadius.all(Radius.circular(40.0.r)),
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 10.0).r,
                child: DrawableText(
                  text: item.name ?? '-',
                  color: Colors.white,
                  size: 12.0.sp,
                  drawableStart: const ImageMultiType(
                    url: Icons.check,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }

  get buttonStyleData => ButtonStyleData(
    width: widget.width ?? 0.9.sw,
    height: 51.0.h,
    elevation: 0,
  );

  get menuItemStyleData => MenuItemStyleData(height: 40.0.h);

  get dropdownStyleData => DropdownStyleData(
    width: widget.dropdownWidth,
    maxHeight: 300.0.h,
    elevation: 0,
    padding: EdgeInsets.zero,
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 10.0.r,
          offset: Offset(0, 6.r),
        )
      ],
      borderRadius: BorderRadius.circular(8.0.r),
    ),
    isOverButton: widget.isOverButton ?? false,
  );

  get iconStyleData => IconStyleData(
    icon: ImageMultiType(
      url: Icons.expand_more,
      height: 18.0.r,
      width: 18.0.r,
      color: AppColorManager.mainColor,
    ),
    iconSize: 35.0.spMin,
  );

  get dropdownSearchData => !widget.searchable
      ? null
      : DropdownSearchData<SpinnerItem>(
    searchController: textEditingController,
    searchInnerWidgetHeight: 70.0.h,
    searchInnerWidget: Container(
      height: 80.0.h,
      padding: const EdgeInsets.only(top: 8, bottom: 4, right: 8, left: 8).r,
      child: MyTextFormOutLineWidget(
        controller: textEditingController,
        hint: 'بحث',
        icon: Icons.search,
      ),
    ),
    searchMatchFn: (item, searchValue) {
      return item.value?.name
          .toString()
          .toLowerCase()
          .contains(searchValue.toLowerCase()) ??
          false;
    },
  );

  get onMenuStateChange => !widget.searchable
      ? null
      : (isOpen) {
    if (!isOpen) {
      textEditingController.clear();
    }
  };
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
    this.id = 0,
    this.isSelected = false,
    this.temp = false,
    this.item,
    this.icon,
    this.enable = true,
  });

  String? name;
  int id;
  bool isSelected;
  bool enable;
  bool temp;
  dynamic item;
  dynamic icon;
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
