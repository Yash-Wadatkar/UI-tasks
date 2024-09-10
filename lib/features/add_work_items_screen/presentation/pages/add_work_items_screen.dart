import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sizer/sizer.dart';
import 'package:ui_tasks/core/const/color_constant.dart';
import 'package:ui_tasks/core/const/custom_style_widget.dart';
import 'package:ui_tasks/features/add_work_items_screen/presentation/bloc/add_work_item_bloc.dart';
import 'package:ui_tasks/features/add_work_items_screen/presentation/bloc/add_work_item_event.dart';
import 'package:ui_tasks/features/add_work_items_screen/presentation/bloc/add_work_item_state.dart';
import 'package:ui_tasks/features/add_work_items_screen/presentation/widgets/work_item_screen_textfield.dart';

class AddWorkItemsScreen extends StatefulWidget {
  const AddWorkItemsScreen({super.key});

  @override
  State<AddWorkItemsScreen> createState() => _AddWorkItemsScreenState();
}

class _AddWorkItemsScreenState extends State<AddWorkItemsScreen> {
  /// creating instance of add work item
  final addWorkItemScreenBloc = AddWorkItemBloc();

  /// creating controllers for textfield
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _defaultUnitsController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _lengthController = TextEditingController();
  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _depthController = TextEditingController();
  final TextEditingController _flagRaisedController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: skyBlueColor,
      appBar: _buildAppBarWidget(),
      body: BlocConsumer(
        bloc: addWorkItemScreenBloc,
        buildWhen: (previous, current) => current is! AddWorkItemListnerState,
        listenWhen: (previous, current) => current is AddWorkItemListnerState,
        listener: (context, state) {
          switch (state.runtimeType) {
            case OpenCalenderSate:
              _showDatePicker();
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case AddWorkItemScreenInitialState:
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 2.h,
                      ),
                      Text(
                        'Add Work Description',
                        style: CustomTextStyle.textStyle(
                            fontSize: 14.spa,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff1e4265)),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      TextFormField(
                        maxLines: 5,
                        // maxLength: 500,
                        decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: InputBorder.none),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        '500 characters remaining',
                        style: TextStyle(
                            fontSize: 10.spa,
                            fontStyle: FontStyle.italic,
                            color: greyColor),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      WorkItemScreenTextfield(
                        textfieldName: 'Select Date',
                        controller: TextEditingController(),
                        suffixIcon: Icon(
                          Icons.calendar_month_outlined,
                          color: blueColor,
                        ),
                        ontap: () {
                          addWorkItemScreenBloc.add(OpenCalenderEvent());
                        },
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      WorkItemScreenTextfield(
                        textfieldName: 'Default Units',
                        controller: TextEditingController(),
                        suffixIcon: Transform.rotate(
                          angle: 55,
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: blueColor,
                            size: 15,
                          ),
                        ),
                        ontap: () {},
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      WorkItemScreenTextfield(
                          textfieldName: 'No',
                          controller: TextEditingController()),
                      SizedBox(
                        height: 1.h,
                      ),
                      WorkItemScreenTextfield(
                          textfieldName: 'Length',
                          controller: TextEditingController()),
                      SizedBox(
                        height: 1.h,
                      ),
                      WorkItemScreenTextfield(
                          textfieldName: 'Width',
                          controller: TextEditingController()),
                      SizedBox(
                        height: 1.h,
                      ),
                      WorkItemScreenTextfield(
                          textfieldName: 'Depth',
                          controller: TextEditingController()),
                      SizedBox(
                        height: 1.5.h,
                      ),
                      Divider(
                        color: greyColor.withOpacity(0.2),
                      ),
                      Row(
                        children: [
                          Checkbox(
                            activeColor: blueColor,
                            focusColor: blueColor,
                            value: true,
                            onChanged: (value) {},
                          ),
                          const Text('Mark this as rework'),
                        ],
                      ),
                      Divider(
                        color: greyColor.withOpacity(0.2),
                      ),
                      SizedBox(
                        height: 1.5.h,
                      ),
                      WorkItemScreenTextfield(
                        textfieldName: 'Flag Raised by',
                        controller: TextEditingController(),
                        suffixIcon: Transform.rotate(
                          angle: 55,
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: blueColor,
                            size: 15,
                          ),
                        ),
                        ontap: () {},
                      ),
                      Row(
                        children: [
                          Checkbox(
                            activeColor: blueColor,
                            focusColor: blueColor,
                            value: true,
                            onChanged: (value) {},
                          ),
                          const Text('Is this rework flag billable?'),
                        ],
                      ),
                    ],
                  ),
                ),
              );

            default:
              return const Center(
                child: Text('Something went wrong'),
              );
          }
        },
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  /// method to build appbar
  PreferredSizeWidget _buildAppBarWidget() {
    return AppBar(
      backgroundColor: Colors.white,
      title: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 3.w, right: 2.w),
            child: Icon(
              Icons.arrow_back_ios,
              color: blueColor,
              size: 20,
            ),
          ),
          Text(
            'Add Work',
            overflow: TextOverflow.ellipsis,
            style: CustomTextStyle.textStyle(
                color: appBarTextColor,
                fontSize: 17.sp,
                fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  /// method to build bottombar
  Widget _buildBottomBar() {
    return Container(
      width: double.infinity,
      height: 12.h,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            blurRadius: 2,
            spreadRadius: 2,
            offset: const Offset(1, 1),
            color: greyColor.withOpacity(0.5))
      ]),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(
                  top: 2.1.h, bottom: 4.h, left: 3.w, right: 3.w),

              /// outline button
              child: OutlinedButton(
                  style: ButtonStyle(
                    shape: const WidgetStatePropertyAll(
                        ContinuousRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(0)))),
                    side: WidgetStatePropertyAll(
                        BorderSide(width: 2, color: blueColor)),
                  ),
                  onPressed: () {},
                  child: Padding(
                    padding: EdgeInsets.all(4.w),
                    child: Text(
                      'Save & Add Another',
                      overflow: TextOverflow.ellipsis,
                      style: CustomTextStyle.textStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w600,
                          color: blueColor),
                    ),
                  )),
            ),
          ),
          SizedBox(
            width: 1.w,
          ),

          /// elevated button for save
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(top: 2.1.h, bottom: 4.h, right: 3.w),
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(blueColor),
                    foregroundColor: const WidgetStatePropertyAll(Colors.white),
                    shape: const WidgetStatePropertyAll(
                        ContinuousRectangleBorder())),
                child: Padding(
                  padding: EdgeInsets.all(4.w),
                  child: Text(
                    'Save',
                    overflow: TextOverflow.ellipsis,
                    style: CustomTextStyle.textStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Method to show calendar date picker
  void _showDatePicker() {
    /// Get the existing date from the text field, if any

    DateTime? initialDate;

    showModalBottomSheet(
      context: context,
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(Radius.zero),
      ),
      backgroundColor: Colors.white,
      showDragHandle: true,
      isDismissible: true,
      isScrollControlled: true,
      enableDrag: false,
      barrierColor: Colors.grey.withOpacity(.9),
      builder: (context) {
        return Container(
          height: 35.h,
          width: double.infinity,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: CalendarDatePicker2(
              config: CalendarDatePicker2Config(
                calendarType: CalendarDatePicker2Type.single,
              ),

              /// Use the initial date (parsed from text or current date)
              value: initialDate != null ? [initialDate] : [],
              onValueChanged: (dates) {
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    );
  }
}
