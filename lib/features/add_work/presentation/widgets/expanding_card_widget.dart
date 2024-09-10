import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:ui_tasks/core/const/color_constant.dart';

import 'package:ui_tasks/core/const/custom_style_widget.dart';

class ExpandingCardWidget extends StatelessWidget {
  final void Function()? ontap;
  final TextEditingController dateController;
  final TextEditingController numberController;
  final TextEditingController lengthController;
  final TextEditingController widthController;
  final TextEditingController depthController;
  const ExpandingCardWidget(
      {super.key,
      this.ontap,
      required this.dateController,
      required this.numberController,
      required this.lengthController,
      required this.widthController,
      required this.depthController});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: true,
      collapsedIconColor: blueColor,
      iconColor: blueColor,
      shape: const ContinuousRectangleBorder(),
      backgroundColor: const Color(0xfff5fbfd),
      collapsedBackgroundColor: const Color(0xffe5f4fb),
      title: Row(
        children: [
          Expanded(
            flex: 13,
            child: Text(
              'North wall excavation work 20A2',
              overflow: TextOverflow.ellipsis,
              style: CustomTextStyle.textStyle(
                  fontSize: 12.2.spa, fontWeight: FontWeight.w500),
            ),
          ),
          const Expanded(flex: 1, child: SizedBox()),
          Expanded(
            flex: 2,
            child: Container(
                decoration: const BoxDecoration(
                    color: Color(0xffe58d5b),
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 0.1.h, horizontal: 1.4.w),
                  child: const Icon(
                    Icons.flag_outlined,
                    color: Colors.white,
                  ),
                )),
          )
        ],
      ),
      children: [
        SizedBox(height: 1.h),
        Row(
          children: [
            const Expanded(
                flex: 2,
                child: Text(
                  'Date',
                  overflow: TextOverflow.ellipsis,
                )),
            const Expanded(flex: 1, child: SizedBox()),
            Expanded(
              flex: 2,
              child: TextField(
                controller: dateController,
                onTap: ontap,
                readOnly: true,
                decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.calendar_month_outlined,
                    color: blueColor,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.zero),
                      borderSide:
                          BorderSide(width: 1.2, color: searchBarBorderColor)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.zero),
                      borderSide:
                          BorderSide(width: 1.2, color: searchBarBorderColor)),
                  contentPadding: EdgeInsets.symmetric(horizontal: 4.w),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.zero)),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 2.h,
        ),
        Row(
          children: [
            const Expanded(
                flex: 2,
                child: Text(
                  'No',
                  overflow: TextOverflow.ellipsis,
                )),
            const Expanded(flex: 1, child: SizedBox()),
            Expanded(
              flex: 2,
              child: TextField(
                controller: numberController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.zero),
                      borderSide:
                          BorderSide(width: 1.2, color: searchBarBorderColor)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.zero),
                      borderSide:
                          BorderSide(width: 1.2, color: searchBarBorderColor)),
                  contentPadding: EdgeInsets.symmetric(horizontal: 4.w),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.zero)),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 2.h,
        ),
        Row(
          children: [
            const Expanded(
                flex: 8,
                child: Text(
                  'Length',
                  overflow: TextOverflow.ellipsis,
                )),
            // const Expanded(flex: 1, child: SizedBox()),
            const Expanded(
                flex: 0,
                child: Text(
                  'YD',
                  overflow: TextOverflow.ellipsis,
                )),
            Expanded(
                flex: 2,
                child: Transform.rotate(
                    angle: 55,
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: blueColor,
                      size: 18,
                    ))),
            const Expanded(flex: 1, child: SizedBox()),
            Expanded(
              flex: 8,
              child: TextField(
                controller: lengthController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.zero),
                      borderSide:
                          BorderSide(width: 1.2, color: searchBarBorderColor)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.zero),
                      borderSide:
                          BorderSide(width: 1.2, color: searchBarBorderColor)),
                  contentPadding: EdgeInsets.symmetric(horizontal: 4.w),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.zero)),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 2.h,
        ),
        Row(
          children: [
            const Expanded(
                flex: 8,
                child: Text(
                  'Width',
                  overflow: TextOverflow.ellipsis,
                )),
            // const Expanded(flex: 1, child: SizedBox()),
            const Expanded(
                flex: 0,
                child: Text(
                  'YD',
                  overflow: TextOverflow.ellipsis,
                )),
            Expanded(
                flex: 2,
                child: Transform.rotate(
                    angle: 55,
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: blueColor,
                      size: 18,
                    ))),
            const Expanded(flex: 1, child: SizedBox()),
            Expanded(
              flex: 8,
              child: TextField(
                controller: widthController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.zero),
                      borderSide:
                          BorderSide(width: 1.2, color: searchBarBorderColor)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.zero),
                      borderSide:
                          BorderSide(width: 1.2, color: searchBarBorderColor)),
                  contentPadding: EdgeInsets.symmetric(horizontal: 4.w),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.zero)),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 2.h,
        ),
        Row(
          children: [
            const Expanded(
                flex: 8,
                child: Text(
                  'Depth',
                  overflow: TextOverflow.ellipsis,
                )),
            // const Expanded(flex: 1, child: SizedBox()),
            const Expanded(
                flex: 0,
                child: Text(
                  'YD',
                  overflow: TextOverflow.ellipsis,
                )),
            Expanded(
                flex: 2,
                child: Transform.rotate(
                    angle: 55,
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: blueColor,
                      size: 18,
                    ))),
            const Expanded(flex: 1, child: SizedBox()),
            Expanded(
              flex: 8,
              child: TextField(
                controller: depthController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.zero),
                      borderSide:
                          BorderSide(width: 1.2, color: searchBarBorderColor)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.zero),
                      borderSide:
                          BorderSide(width: 1.2, color: searchBarBorderColor)),
                  contentPadding: EdgeInsets.symmetric(horizontal: 4.w),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.zero)),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 2.h,
        ),
        Row(
          children: [
            Expanded(
                flex: 3,
                child: Text(
                  'Sub Total(CY)',
                  overflow: TextOverflow.ellipsis,
                  style: CustomTextStyle.textStyle(
                      color: greyColor, fontSize: 12.spa),
                )),
            Expanded(
                flex: 2,
                child: Text(
                  ' 80.64',
                  overflow: TextOverflow.ellipsis,
                  style: CustomTextStyle.textStyle(fontWeight: FontWeight.w400),
                )),
          ],
        ),
        SizedBox(height: 3.h)
      ],
    );
  }
}
