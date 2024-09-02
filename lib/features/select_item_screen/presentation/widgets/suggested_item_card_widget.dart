import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:ui_tasks/core/const/custom_style_widget.dart';

class SuggestedItemCardWidget extends StatelessWidget {
  const SuggestedItemCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 2, color: const Color(0xff8bb3d8)),
          color: const Color(0xffe5f4fb)),
      child: Row(
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(children: [
                    TextSpan(
                        text: '1.1.6 ',
                        style: CustomTextStyle.textStyle(
                            fontSize: 15.sp, fontWeight: FontWeight.w500)),
                    TextSpan(
                        text: ' Structural Excavation Class A Incl Haul',
                        style: CustomTextStyle.textStyle(fontSize: 14.sp))
                  ]))),
        ],
      ),
    );
  }
}
