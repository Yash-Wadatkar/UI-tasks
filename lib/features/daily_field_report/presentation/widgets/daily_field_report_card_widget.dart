import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:ui_tasks/core/const/custom_style_widget.dart';

class DailyFieldReportCardWidget extends StatelessWidget {
  final String dfrName;
  final String? date;
  final String? toDate;
  final String? fromDate;
  const DailyFieldReportCardWidget(
      {super.key,
      required this.dfrName,
      required this.date,
      required this.toDate,
      required this.fromDate});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 12.h,
      child: Card(
        shape: const ContinuousRectangleBorder(),
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(3.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 10,
                    child: Text(
                      dfrName,
                      style: CustomTextStyle.textStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const Expanded(flex: 3, child: SizedBox()),
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: const BoxDecoration(color: Color(0xffb46b26)),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4.w, vertical: 0.4.h),
                            child: Text(
                              '0',
                              style: CustomTextStyle.textStyle(
                                  fontSize: 15.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 3.h,
              ),
              Text(
                  date == null || date!.isEmpty
                      ? '$toDate to $fromDate'
                      : date!,
                  overflow: TextOverflow.ellipsis,
                  style: CustomTextStyle.textStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff8f9091),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
