import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:ui_tasks/core/const/color_constant.dart';
import 'package:ui_tasks/core/const/custom_style_widget.dart';
import 'package:ui_tasks/features/add_work/presentation/bloc/add_work_screen_bloc.dart';
import 'package:ui_tasks/features/add_work/presentation/bloc/add_work_screen_event.dart';
import 'package:ui_tasks/features/add_work/presentation/bloc/add_work_screen_state.dart';

import 'package:ui_tasks/features/add_work/presentation/widgets/expanding_card_widget.dart';

class AddWorkScreen extends StatefulWidget {
  const AddWorkScreen({super.key});

  @override
  State<AddWorkScreen> createState() => _AddWorkScreenState();
}

class _AddWorkScreenState extends State<AddWorkScreen> {
  /// creating instance of add work screen bloc
  final addWorkScreenBloc = AddWorkScreenBloc();

  /// creating variable for date
  DateTime? _selectedDate;

  /// creating textcontroller for date field
  List<TextEditingController> _dateControllers = [];

  @override
  void initState() {
    super.initState();
    // Initialize text controllers based on the number of items
    _dateControllers = List.generate(3, (_) => TextEditingController());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    /// disposing date controller
    _dateControllers;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBarWidget(),
        body: BlocConsumer(
          bloc: addWorkScreenBloc,
          buildWhen: (previous, current) =>
              current is! AddWorkScreenListnerState,
          listenWhen: (previous, current) =>
              current is AddWorkScreenListnerState,
          listener: (context, state) {
            switch (state.runtimeType) {
              case OpenCalenderState:
                final openCalenderState = state as OpenCalenderState;
                _showDatePicker(openCalenderState.index);
            }
          },
          builder: (context, state) {
            switch (state.runtimeType) {
              case AddWorkScreenInitialState:
                return ListView.builder(
                  itemCount: 3,
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                      child: ExpandingCardWidget(
                        dateController: _dateControllers[index],
                        ontap: () {
                          addWorkScreenBloc
                              .add(OpenCalenderEvent(index: index));
                        },
                      ),
                    );
                  },
                );

              default:
                return const Center(child: Text('Something Went Wrong'));
            }
          },
        ),
        bottomNavigationBar: _buildBottomBar());
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
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Add Work',
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
                  padding: const EdgeInsets.all(12.0),
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

  /// method to built appbar
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
            'Back',
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

  /// Method to show calendar date picker
  void _showDatePicker(int index) {
    /// Get the existing date from the text field, if any
    String existingDateText = _dateControllers[index].text;
    DateTime? initialDate;

    if (existingDateText.isNotEmpty) {
      /// Parse the existing date from the text field, if it's not empty
      initialDate = DateFormat('LLL-dd-yyyy').parse(existingDateText);
    } else {
      /// Set the initial date to the current date if no date is selected
      initialDate = DateTime.now();
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: Padding(
            padding: EdgeInsets.all(2.w),
            child: SizedBox(
              width: 80.w,
              height: 30.h,
              child: CalendarDatePicker2(
                config: CalendarDatePicker2Config(
                  calendarType: CalendarDatePicker2Type.single,
                ),

                /// Use the initial date (parsed from text or current date)
                value: initialDate != null ? [initialDate] : [],
                onValueChanged: (dates) {
                  if (dates.isNotEmpty) {
                    // Assign the selected date
                    _selectedDate = dates.first;
                    _dateControllers[index].text = _formatDate(_selectedDate!);
                  }
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        );
      },
    );
  }

  /// Helper method to format date to a string
  String _formatDate(DateTime date) {
    return DateFormat('LLL-dd-yyyy').format(date);
  }
}
