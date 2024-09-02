import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:ui_tasks/core/const/color_constant.dart';
import 'package:ui_tasks/core/const/custom_style_widget.dart';
import 'package:ui_tasks/core/const/string_constants.dart';

class PopUpWidget extends StatelessWidget {
  const PopUpWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: greenColor),
      child: Padding(
        padding: EdgeInsets.all(3.5.w),
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/icons/complete.svg',
              height: 4.w,
              color: Colors.white,
            ),
            SizedBox(
              width: 2.w,
            ),
            Text(
              popUpSuccessText,
              style: CustomTextStyle.textStyle(color: Colors.white),
            ),
            const Spacer(),
            Icon(
              Icons.close,
              color: Colors.white,
              size: 5.w,
            )
          ],
        ),
      ),
    );
  }
}
