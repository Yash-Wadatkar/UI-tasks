import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:ui_tasks/core/const/color_constant.dart';
import 'package:ui_tasks/core/const/custom_style_widget.dart';

/// description widget
class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Structural Excavation Class A Incl.Haul',
          overflow: TextOverflow.ellipsis,
          style: CustomTextStyle.textStyle(
              fontSize: 13.spa, fontWeight: FontWeight.w500, color: blueColor),
        ),
        SizedBox(height: 1.h),
        Container(
          decoration: const BoxDecoration(color: Color(0xffe5f4fb)),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 3.w),
            child: Column(
              children: [
                const Row(
                  children: [
                    Expanded(flex: 1, child: Text('Item Unit')),
                    Expanded(flex: 0, child: Text('CY'))
                  ],
                ),
                SizedBox(height: 0.7.h),
                const Row(
                  children: [
                    Expanded(flex: 1, child: Text('Item Code')),
                    Expanded(flex: 0, child: Text('1.1.6'))
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 1.5.h),
        Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
                blurRadius: 5,
                spreadRadius: 0,
                offset: const Offset(0, 1),
                color: greyColor.withOpacity(0.2))
          ]),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 3.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Line Item Description',
                  overflow: TextOverflow.ellipsis,
                  style: CustomTextStyle.textStyle(
                      fontSize: 12.spa,
                      fontWeight: FontWeight.w500,
                      color: blueColor),
                ),
                SizedBox(
                  height: 1.h,
                ),
                const Text(
                  'Structural Excavation Class A Incl. Haul',
                  overflow: TextOverflow.ellipsis,
                ),
                Divider(color: greyColor.withOpacity(0.4)),
                SizedBox(height: 1.h),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Text(
                          'Payment Str.Qty',
                          overflow: TextOverflow.ellipsis,
                          style: CustomTextStyle.textStyle(
                              fontSize: 11.spa, color: greyColor),
                        )),
                    const Expanded(
                        flex: 0,
                        child: Text(
                          '4,000.00 CY',
                          overflow: TextOverflow.ellipsis,
                        ))
                  ],
                ),
                SizedBox(height: 1.h),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Text(
                          'Exacuted Qty till date',
                          overflow: TextOverflow.ellipsis,
                          style: CustomTextStyle.textStyle(
                              fontSize: 11.spa, color: greyColor),
                        )),
                    const Expanded(
                        flex: 0,
                        child: Text(
                          '290.00 CY',
                          overflow: TextOverflow.ellipsis,
                        ))
                  ],
                ),
                SizedBox(height: 1.h),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Text(
                          'MB Qty',
                          overflow: TextOverflow.ellipsis,
                          style: CustomTextStyle.textStyle(
                              fontSize: 11.spa, color: greyColor),
                        )),
                    const Expanded(
                        flex: 0,
                        child: Text(
                          '150.00 CY',
                          overflow: TextOverflow.ellipsis,
                        ))
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
