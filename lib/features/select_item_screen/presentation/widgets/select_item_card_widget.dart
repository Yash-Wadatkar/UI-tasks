import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:ui_tasks/core/const/color_constant.dart';
import 'package:ui_tasks/core/const/custom_style_widget.dart';
import 'package:ui_tasks/core/const/string_constants.dart';

/// item card widget
class SelectItemCardWidget extends StatelessWidget {
  final String itemTableHeading;
  final bool isSelected;
  final ValueChanged<bool> onSelected;
  const SelectItemCardWidget(
      {super.key,
      required this.itemTableHeading,
      required this.isSelected,
      required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(2),
              topRight: Radius.circular(2),
            ),
            color: cardHeadingBackgroundColor,
          ),
          child: Padding(
            padding: EdgeInsets.all(0.2.h),
            child: Row(
              children: [
                Checkbox(
                  shape: const ContinuousRectangleBorder(
                    side: BorderSide(color: Color(0xff246fb5), width: 1.5),
                  ),
                  activeColor: const Color(0xff246fb5),
                  value: isSelected,
                  onChanged: (value) {
                    onSelected(value!);
                  },
                ),
                Expanded(
                  flex: 6,
                  child: Text(
                    itemTableHeading,
                    style: CustomTextStyle.textStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Expanded(flex: 1, child: SizedBox()),
              ],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4), // Slightly lighter shadow
                offset: const Offset(0, 2), // Shadow offset
                blurRadius: 6, // Blur radius
                spreadRadius: 0, // Spread radius
              ),
            ],
          ),
          child: Table(
            border: TableBorder(
              horizontalInside: BorderSide(
                width: 0.3.w,
                color: lightGreyColor,
              ),
              verticalInside: BorderSide.none, // No vertical lines
              top: BorderSide.none,
              bottom: BorderSide.none,
              left: BorderSide.none,
              right: BorderSide.none,
            ),
            columnWidths: {
              0: FixedColumnWidth(40.w),

              /// Adjusting width for first column
              1: FixedColumnWidth(30.w),

              /// Adjusting width for second column
            },
            children: [
              for (var item in itemsList)
                TableRow(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(top: 1.5.h, left: 5.w, bottom: 1.h),
                      child: Text(
                        item['item']!,
                        style: CustomTextStyle.textStyle(
                          fontSize: 15.sp,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 1.5.h, right: 15.w, bottom: 1.h),
                      child: Text(
                        item['qty']!,
                        style: CustomTextStyle.textStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}
