import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:ui_tasks/core/const/color_constant.dart';
import 'package:ui_tasks/core/const/custom_style_widget.dart';
import 'package:ui_tasks/core/const/string_constants.dart';
import 'package:ui_tasks/core/local_data/local_dfr_data.dart';
import 'package:ui_tasks/features/daily_field_report/presentation/bloc/daily_field_report_bloc.dart';
import 'package:ui_tasks/features/daily_field_report/presentation/bloc/daily_field_report_state.dart';
import 'package:ui_tasks/features/daily_field_report/presentation/bloc/daily_field_repost_event.dart';
import 'package:ui_tasks/features/daily_field_report/presentation/widgets/custom_text_field_widget.dart';
import 'package:ui_tasks/features/daily_field_report/presentation/widgets/daily_field_report_card_widget.dart';
import 'package:ui_tasks/features/daily_field_report/presentation/widgets/no_dfr_added_text_widget.dart';

class DailyFieldReportScreen extends StatefulWidget {
  const DailyFieldReportScreen({super.key});

  @override
  State<DailyFieldReportScreen> createState() => _DailyFieldReportScreenState();
}

class _DailyFieldReportScreenState extends State<DailyFieldReportScreen> {
  /// Creating instance of daily field report screen bloc
  final dailyFieldReportScreenBloc = DailyFieldReportBloc();

  /// creating textcontroller for dfr name textfield
  final TextEditingController nameController = TextEditingController();

  /// Creating text controllers to display date in text fields
  final TextEditingController dateController = TextEditingController();
  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();

  DateTime? _selectedDate = null;
  DateTime? _selectedFromDate = null;
  DateTime? _selectedToDate = null;

  final bool _ischecked = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        bloc: dailyFieldReportScreenBloc,
        buildWhen: (previous, current) =>
            current is! DailyFieldReportScreenListenerState,
        listenWhen: (previous, current) =>
            current is DailyFieldReportScreenListenerState,
        listener: (context, state) {
          if (state is OpenBottomModelSheetState) {
            _showBottomSheet(context, state.ischecked);
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case DailyFieldReportScreenInitialState:
              final initState = state as DailyFieldReportScreenInitialState;

              if (initState.dfrDataList!.isEmpty) {
                print('inside if');
                return Scaffold(
                  backgroundColor: skyBlueColor,
                  appBar: _buildAppBarWidget(),
                  body: NoDfrAddedTextWidget(
                    onpress: () {
                      dailyFieldReportScreenBloc.add(
                          OpenBottomModelSheetEvent(ischecked: _ischecked));
                    },
                  ),
                );
              } else {
                print('inside elsse');
                return Scaffold(
                  backgroundColor: skyBlueColor,
                  appBar: _buildAppBarWidget(),
                  body: ListView.builder(
                    padding: EdgeInsets.all(2.w),
                    itemCount: initState.dfrDataList!.length,
                    itemBuilder: (context, index) {
                      //log(initState.dfrDataList!.length.toString());
                      return DailyFieldReportCardWidget(
                        fromDate: initState.dfrDataList![index].fromDate,
                        toDate: initState.dfrDataList![index].toDate,
                        date: initState.dfrDataList![index].date,
                        dfrName: initState.dfrDataList![index].dfrName,
                      );
                    },
                  ),
                  floatingActionButton: FloatingActionButton(
                    backgroundColor: blueColor,
                    foregroundColor: Colors.white,
                    child: const Icon(Icons.add),
                    onPressed: () {
                      nameController.clear();
                      dailyFieldReportScreenBloc.add(
                          OpenBottomModelSheetEvent(ischecked: _ischecked));
                    },
                  ),
                );
              }

            default:
              return const Scaffold(
                  body: Center(child: Text('Something went wrong')));
          }
        });
  }

  /// method to show bottom model sheet
  void _showBottomSheet(BuildContext context, bool ischecked) {
    final _formKey = GlobalKey<FormState>();
    showModalBottomSheet(
      shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.zero)),
      backgroundColor: Colors.white,
      showDragHandle: true,
      isDismissible: true,
      isScrollControlled: true,
      enableDrag: false,
      barrierColor: Colors.grey.withOpacity(.9),
      context: context,
      builder: (context) {
        return BlocConsumer(
          bloc: dailyFieldReportScreenBloc,
          listenWhen: (previous, current) =>
              current is DailyFieldReportScreenListenerState,
          listener: (context, state) {
            if (state is OpenDatePickerState) {
              _showDatePicker(state.textfieldName);
            } else if (state is SelectDateState) {
              String formattedDate =
                  state.selectedDate.toLocal().toString().split(' ')[0];
              switch (state.field) {
                case 'date':
                  dateController.text = formattedDate;
                  break;
                case 'fromDate':
                  fromDateController.text = formattedDate;
                  break;
                case 'toDate':
                  toDateController.text = formattedDate;
                  break;
              }
            }
          },
          buildWhen: (previous, current) => current is CheckboxToggledState,
          builder: (context, state) {
            if (state is CheckboxToggledState) {
              ischecked = state.isChecked;
            }
            print('-------------------> form rebuild');
            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Padding(
                  /// prevent the overlap of textfield with keyboard
                  ///  viewInsets.bottom gives  how much space the system UI (like the keyboard) is taking up from the bottom of the screen.
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Container(
                    height: 45.h,
                    width: double.infinity,
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 1.h),
                          Text(
                            addDFRText,
                            style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                                color: blueColor),
                          ),
                          SizedBox(height: 1.5.h),

                          /// Widget for custom textfield
                          CustomTextFieldWidget(
                            controller: nameController,
                            textfieldName: 'DFR Name',
                            validator: (value) {
                              print('-------------------> validation rebuild');
                              if (value == null || value.isEmpty) {
                                return 'Please enter a DFR Name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 2.5.h),
                          ischecked
                              ? Row(
                                  children: [
                                    Expanded(
                                      flex: 8,
                                      child: CustomTextFieldWidget(
                                        controller: fromDateController,
                                        textfieldName: 'From',
                                        suffixIcon: Icon(
                                          Icons.calendar_month_outlined,
                                          color: blueColor,
                                        ),
                                        onpress: () {
                                          dailyFieldReportScreenBloc.add(
                                              OpenDatePickerEvent(
                                                  textfieldName: 'fromDate'));
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please select a From date';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    const Expanded(flex: 1, child: SizedBox()),
                                    Expanded(
                                      flex: 8,
                                      child: CustomTextFieldWidget(
                                        controller: toDateController,
                                        textfieldName: 'To',
                                        suffixIcon: Icon(
                                          Icons.calendar_month_outlined,
                                          color: blueColor,
                                        ),
                                        onpress: () {
                                          dailyFieldReportScreenBloc.add(
                                              OpenDatePickerEvent(
                                                  textfieldName: 'toDate'));
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please select a To date';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              : CustomTextFieldWidget(
                                  controller: ischecked
                                      ? TextEditingController()
                                      : dateController,
                                  textfieldName: 'Date',
                                  suffixIcon: Icon(
                                    Icons.calendar_month_outlined,
                                    color: blueColor,
                                  ),
                                  onpress: () {
                                    dailyFieldReportScreenBloc.add(
                                        OpenDatePickerEvent(
                                            textfieldName: 'date'));
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please select a date';
                                    }
                                    return null;
                                  },
                                ),

                          SizedBox(height: 1.5.h),
                          Row(
                            children: [
                              Checkbox(
                                activeColor: blueColor,
                                shape: const ContinuousRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.zero)),
                                value: ischecked,
                                onChanged: (value) {
                                  /// reset the current state of the
                                  _formKey.currentState!.reset();
                                  dailyFieldReportScreenBloc.add(
                                      ToggleCheckboxEvent(isChecked: value!));
                                  if (value) {
                                    /// Clear date when multi-day is selected
                                    dateController.clear();

                                    /// select day value chnage to null
                                    _selectedDate = null;
                                  } else {
                                    /// Clear from/to dates when single day is selected
                                    fromDateController.clear();
                                    toDateController.clear();

                                    /// select day value chnage to null
                                    _selectedFromDate = null;
                                    _selectedToDate = null;
                                  }
                                },
                              ),
                              const Text(
                                  'This log represents progress over multiple days'),
                            ],
                          ),

                          SizedBox(height: 2.5.h),
                          Row(
                            children: [
                              /// cancel button
                              Expanded(
                                flex: 6,
                                child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      shape: const ContinuousRectangleBorder(
                                          borderRadius:
                                              BorderRadius.all(Radius.zero)),
                                      side: BorderSide(
                                          width: 2.0, color: blueColor),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 1.5.h),
                                      child: Text(
                                        cancelText,
                                        overflow: TextOverflow.ellipsis,
                                        style: CustomTextStyle.textStyle(
                                            fontSize: 16.sp,
                                            color: blueColor,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )),
                              ),

                              const Expanded(flex: 1, child: SizedBox()),

                              /// Add DFR Button
                              Expanded(
                                flex: 6,
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            WidgetStatePropertyAll(blueColor),
                                        shape: const WidgetStatePropertyAll(
                                            ContinuousRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.zero)))),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        // Add validation check
                                        dailyFieldReportScreenBloc.add(
                                          AddDFRButtonClickedEvent(
                                            dfrData: DfrData(
                                              dfrName: nameController.text,
                                              date: dateController.text,
                                              fromDate: fromDateController.text,
                                              toDate: toDateController.text,
                                            ),
                                          ),
                                        );
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 1.5.h),
                                      child: Text(
                                        addDFRText,
                                        overflow: TextOverflow.ellipsis,
                                        style: CustomTextStyle.textStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                    )),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    ).whenComplete(
      () {
        /// clear controllers data and reset the dates when action is complete
        _clearControllersData();
        _resetDates();
      },
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
              color: blackColor,
              size: 20,
            ),
          ),
          Text(
            dailyFieldReportText,
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

  /// Method to show calendar date picker and pick dates for both single and multi-date selection
  void _showDatePicker(String field) {
    showModalBottomSheet(
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(Radius.zero),
      ),
      backgroundColor: Colors.white,
      showDragHandle: true,
      isDismissible: true,
      isScrollControlled: true,
      enableDrag: false,
      barrierColor: Colors.grey.withOpacity(.9),
      context: context,
      builder: (context) {
        return Container(
          height: 35.h,
          width: double.infinity,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: CalendarDatePicker2(
              config: CalendarDatePicker2Config(
                calendarType: CalendarDatePicker2Type.single,
                selectableDayPredicate: (date) {
                  if (field == 'fromDate') {
                    // Disable all dates after the current selected "To" date
                    if (_selectedToDate != null &&
                        date.isAfter(_selectedToDate!)) {
                      return false;
                    }
                  }

                  if (field == 'toDate') {
                    // Disable all dates before the selected "From" date
                    if (_selectedFromDate != null &&
                        date.isBefore(_selectedFromDate!)) {
                      return false;
                    }
                  }

                  return true;
                },
              ),
              value: _getInitialDatesForField(field),
              onValueChanged: (dates) async {
                if (dates.isNotEmpty) {
                  if (field == 'date') {
                    _selectedDate = dates.first;
                    dailyFieldReportScreenBloc.add(
                      SelectDateEvent(_selectedDate!, field),
                    );
                  } else if (field == 'fromDate') {
                    _selectedFromDate = dates.first;
                    dailyFieldReportScreenBloc.add(
                      SelectDateEvent(_selectedFromDate!, field),
                    );

                    // Clear and reset "To" date if it's before the new "From" date
                    if (_selectedToDate != null &&
                        _selectedFromDate!.isAfter(_selectedToDate!)) {
                      _selectedToDate = null;
                      toDateController.clear();
                    }
                  } else if (field == 'toDate') {
                    _selectedToDate = dates.first;
                    dailyFieldReportScreenBloc.add(
                      SelectDateEvent(_selectedToDate!, field),
                    );

                    // Clear and reset "From" date if it's after the new "To" date
                    if (_selectedFromDate != null &&
                        _selectedToDate!.isBefore(_selectedFromDate!)) {
                      _selectedFromDate = null;
                      fromDateController.clear();
                    }
                  }

                  await Future.delayed(const Duration(milliseconds: 400));
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                }
              },
            ),
          ),
        );
      },
    );
  }

  /// Method to get the initial dates for each field
  List<DateTime?> _getInitialDatesForField(String field) {
    switch (field) {
      case 'date':
        return _selectedDate != null ? [_selectedDate!] : [];
      case 'fromDate':
        return _selectedFromDate != null ? [_selectedFromDate!] : [];
      case 'toDate':
        return _selectedToDate != null ? [_selectedToDate!] : [];
      default:
        return [];
    }
  }

  /// method to clear all controllers data
  void _clearControllersData() {
    /// clearing the controllers data on press of cancel button
    dateController.clear();
    nameController.clear();
    toDateController.clear();
    fromDateController.clear();
  }

  /// method to reset the dates
  void _resetDates() {
    /// reset the dates
    _selectedDate = null;
    _selectedFromDate = null;
    _selectedToDate = null;
  }
}
