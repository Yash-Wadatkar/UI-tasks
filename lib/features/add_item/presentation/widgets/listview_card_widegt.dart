import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:ui_tasks/core/const/color_constant.dart';
import 'package:ui_tasks/core/const/custom_style_widget.dart';
import 'package:ui_tasks/core/const/string_constants.dart';

// listview card widget conatining table
class ListviewCardWidegt extends StatelessWidget {
  final String tableHeading;
  const ListviewCardWidegt({super.key, required this.tableHeading});

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
            padding: EdgeInsets.all(2.h),
            child: Row(
              children: [
                Expanded(
                  flex: 8,
                  child: Text(
                    tableHeading,
                    style: CustomTextStyle.textStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Expanded(flex: 1, child: SizedBox()),
                Expanded(
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 4.w,
                    color: blueColor,
                  ),
                ),
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
              TableRow(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(top: 1.5.h, left: 5.w, bottom: 1.h),
                    child: Text(
                      status,
                      style: CustomTextStyle.textStyle(
                        fontSize: 16.sp,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 1.h, right: 15.w, bottom: 1.h),
                    child: Container(
                      decoration: BoxDecoration(color: inProgressBoxColor),
                      child: Padding(
                        padding:
                            EdgeInsets.only(top: 1.w, left: 3.w, bottom: 1.w),
                        child: Text(
                          inProgress,
                          style: CustomTextStyle.textStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              //// itreating throught the list to create the exact no.of rows
              for (var item in data)
                TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 1.3.h, horizontal: 5.w),
                      child: Text(
                        item['Status']!,
                        style: CustomTextStyle.textStyle(fontSize: 16.sp),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.3.h),
                      child: Text(
                        item['In Progress']!,
                        style: CustomTextStyle.textStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w500),
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
