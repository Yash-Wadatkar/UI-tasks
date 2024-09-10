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
import 'package:ui_tasks/features/add_work/presentation/widgets/description_widget.dart';

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

  /// Map to store controllers for each index
  final Map<int, Map<String, TextEditingController>> _controllers = {};

  final Map<int, Map<String, String>> _data = {};

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 3; i++) {
      _controllers[i] = {
        'date': TextEditingController(),
        'number': TextEditingController(),
        'length': TextEditingController(),
        'width': TextEditingController(),
        'depth': TextEditingController(),
      };
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose

    /// Dispose of all text controllers
    _controllers.values.forEach((controllers) {
      controllers.values.forEach((controller) => controller.dispose());
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: skyBlueColor,
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
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Column(
                      children: [
                        /// description widget
                        const DescriptionWidget(),
                        SizedBox(height: 1.h),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 1.h),
                              child: ExpandingCardWidget(
                                dateController: _controllers[index]!['date']!,
                                numberController:
                                    _controllers[index]!['number']!,
                                lengthController:
                                    _controllers[index]!['length']!,
                                widthController: _controllers[index]!['width']!,
                                depthController: _controllers[index]!['depth']!,
                                ontap: () {
                                  addWorkScreenBloc
                                      .add(OpenCalenderEvent(index: index));
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
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
                onPressed: () {
                  _saveData();
                },
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
    String existingDateText = _controllers[index]!['date']!.text;
    DateTime? initialDate;

    if (existingDateText.isNotEmpty) {
      /// Parse the existing date from the text field, if it's not empty
      initialDate = DateFormat('LLL-dd-yyyy').parse(existingDateText);
    } else {
      /// Set the initial date to the current date if no date is selected
      initialDate = DateTime.now();
    }
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
                if (dates.isNotEmpty) {
                  // Assign the selected date
                  _selectedDate = dates.first;
                  _controllers[index]!['date']!.text =
                      _formatDate(_selectedDate!);
                }
                Navigator.pop(context);
              },
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

  ///
  void _saveData() {
    final data = _controllers.map((index, controllers) {
      return MapEntry(
        index,
        {
          'date': controllers['date']!.text,
          'number': controllers['number']!.text,
          'length': controllers['length']!.text,
          'width': controllers['width']!.text,
          'depth': controllers['depth']!.text,
        },
      );
    });

    // Implement save functionality with the collected data
    print('Saved Data: $data');
  }
}
