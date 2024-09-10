import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:ui_tasks/core/const/color_constant.dart';
import 'package:ui_tasks/core/const/custom_style_widget.dart';

class WorkItemScreenTextfield extends StatelessWidget {
  final String textfieldName;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final void Function()? ontap;
  final String? Function(String?)? validator;

  const WorkItemScreenTextfield(
      {super.key,
      required this.textfieldName,
      required this.controller,
      this.suffixIcon,
      this.ontap,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        textfieldName,
        style: CustomTextStyle.textStyle(
            fontSize: 15.sp, fontWeight: FontWeight.w500),
      ),
      SizedBox(height: 1.h),
      TextFormField(
          validator: validator,
          onTap: ontap,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          readOnly: suffixIcon == null ? false : true,
          decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
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
              suffixIcon: suffixIcon))
    ]);
  }
}
