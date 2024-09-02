import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:ui_tasks/core/const/color_constant.dart';
import 'package:ui_tasks/core/const/custom_style_widget.dart';
import 'package:ui_tasks/core/const/string_constants.dart';

/// search bar widget
class SearchBarWidget extends StatelessWidget {
  final Function(String) onSearch;
  const SearchBarWidget({super.key, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onSearch,
      decoration: InputDecoration(
          hintText: search,
          hintStyle: CustomTextStyle.textStyle(
              color: greyColor, fontWeight: FontWeight.w500),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(0)),
            borderSide: BorderSide(
              style: BorderStyle.solid,
              color: searchBarBorderColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(0)),
            borderSide: BorderSide(
                style: BorderStyle.solid, color: searchBarBorderColor),
          ),
          filled: true,
          fillColor: Colors.white,
          suffixIcon:
              Icon(Icons.search, color: greyColor), // Search icon at the end
          contentPadding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.w)),
    );
  }
}
