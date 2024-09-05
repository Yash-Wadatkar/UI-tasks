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

  DateTime? _selectedDate = DateTime.now();
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

            if (!ischecked) {
              dateController.clear();
            } else {
              fromDateController.clear();
              toDateController.clear();
            }

            return Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
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
                                        return 'Please select a From date';
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
                                    OpenDatePickerEvent(textfieldName: 'date'));
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select a From date';
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
                                borderRadius: BorderRadius.all(Radius.zero)),
                            value: ischecked,
                            onChanged: (value) {
                              dailyFieldReportScreenBloc
                                  .add(ToggleCheckboxEvent(isChecked: value!));
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
                                  side:
                                      BorderSide(width: 2.0, color: blueColor),
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
            );
          },
        );
      },
    );
  }

  /// method to built appbar
  PreferredSizeWidget _buildAppBarWidget() {
    return AppBar(
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

  /// method to show calender date picker and pick dates
  void _showDatePicker(String field) async {
    _selectedDate = DateTime.now();
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
        return Container(
          height: 35.h,
          width: double.infinity,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: CalendarDatePicker2(
              config: CalendarDatePicker2Config(
                calendarType: CalendarDatePicker2Type.single,
              ),
              value: _selectedDate != null ? [_selectedDate!] : [],
              onValueChanged: (dates) async {
                if (dates.isNotEmpty) {
                  _selectedDate = dates.first;
                  dailyFieldReportScreenBloc.add(
                    SelectDateEvent(_selectedDate!, field),
                  );

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
}
