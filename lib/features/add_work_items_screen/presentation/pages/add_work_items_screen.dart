import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:ui_tasks/core/const/color_constant.dart';
import 'package:ui_tasks/core/const/custom_style_widget.dart';
import 'package:ui_tasks/core/const/string_constants.dart';
import 'package:ui_tasks/core/repository/work_repository.dart';

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
  /// instance of work repo class to send data to map in work repo class
  final WorkRepository workRepository = WorkRepository();

  /// creating instance of add work item
  late final AddWorkItemBloc addWorkItemScreenBlocOne;
  late final AddWorkItemBloc addWorkItemScreenBlocTwo;

  /// creating controllers for textfield
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _defaultUnitsController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _lengthController = TextEditingController();
  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _depthController = TextEditingController();
  final TextEditingController _flagRaisedController = TextEditingController();

  // Example list
  final List<String> units = ['Unit 1', 'Unit 2', 'Unit 3'];
  final List<String> clientsList = ['Client1', 'Client2', 'Client3'];

  /// Variables to check/uncheck the checkboxes
  bool _isReworkChecked = false;
  bool _isFlagBillableChecked = false;

  /// max length of description for description textfield
  final int _descriptionMaxLength = 500;

  /// map to store the data from field
  final Map<String, String> mapData = {};

  /// form key for validating
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    addWorkItemScreenBlocOne = AddWorkItemBloc(workRepository: workRepository);
    addWorkItemScreenBlocTwo = AddWorkItemBloc(workRepository: workRepository);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: skyBlueColor,

      /// method to build appbar
      appBar: _buildAppBarWidget(),
      body: BlocConsumer(
        bloc: addWorkItemScreenBlocOne,
        buildWhen: (previous, current) => current is! AddWorkItemListnerState,
        listenWhen: (previous, current) => current is AddWorkItemListnerState,
        listener: (context, state) {
          switch (state.runtimeType) {
            case OpenCalenderSate:

              /// method to sshow date picker
              _showDatePicker();

            case SelectValueState:

              /// if drop down is select unit then assign value to unit controller
              /// if its flag raised then assign value to flagraised controller
              final selectedValueState = state as SelectValueState;
              if (selectedValueState.fieldName == 'Default Units') {
                _defaultUnitsController.text = selectedValueState.value;
              } else if (selectedValueState.fieldName == 'Flag Raised by') {
                _flagRaisedController.text = selectedValueState.value;
              }

            case CheckBoxClickState:
              final checkBoxState = state as CheckBoxClickState;

              if (checkBoxState.fieldName == 'Rework') {
                _isReworkChecked = checkBoxState.isChecked;
              } else if (checkBoxState.fieldName == 'Flag Billable') {
                _isFlagBillableChecked = checkBoxState.isChecked;
              }
          }
        },
        builder: (context, state) {
          print('Builid state');
          switch (state.runtimeType) {
            case AddWorkItemScreenInitialState:
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(
                          addWorkDescriptionText,
                          style: CustomTextStyle.textStyle(
                              fontSize: 14.spa,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff1e4265)),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Description';
                            }
                            return null;
                          },
                          controller: _descriptionController,
                          maxLines: 5,
                          maxLength: 500,
                          decoration: const InputDecoration(
                              counterText: '',
                              filled: true,
                              fillColor: Colors.white,
                              border: InputBorder.none),
                          onChanged: (value) {
                            addWorkItemScreenBlocTwo
                                .add(DescriptionChangedEvent());
                          },
                        ),
                        SizedBox(height: 1.h),
                        BlocBuilder(
                          bloc: addWorkItemScreenBlocTwo,
                          buildWhen: (previous, current) =>
                              current is! AddWorkItemListnerState,
                          builder: (context, state) {
                            return Text(
                              '${_descriptionMaxLength - _descriptionController.text.length} characters remaining',
                              style: TextStyle(
                                  fontSize: 10.spa,
                                  fontStyle: FontStyle.italic,
                                  color: greyColor),
                            );
                          },
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        WorkItemScreenTextfield(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select Date';
                            }
                            return null;
                          },
                          textfieldName: 'Select Date',
                          controller: _dateController,
                          suffixIcon: Icon(
                            Icons.calendar_month_outlined,
                            color: blueColor,
                          ),
                          ontap: () {
                            addWorkItemScreenBlocOne.add(OpenCalenderEvent());
                          },
                        ),
                        SizedBox(
                          height: 1.h,
                        ),

                        /// widget to build drop down

                        _buildDropDownWidget(
                            textfieldName: "Default Units",
                            hintText: 'Select a unit',
                            list: units,
                            dropDownController: _defaultUnitsController),

                        SizedBox(
                          height: 1.h,
                        ),
                        WorkItemScreenTextfield(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter number';
                              }
                              return null;
                            },
                            textfieldName: 'No',
                            controller: _numberController),
                        SizedBox(
                          height: 1.h,
                        ),
                        WorkItemScreenTextfield(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter length';
                              }
                              return null;
                            },
                            textfieldName: 'Length',
                            controller: _lengthController),
                        SizedBox(
                          height: 1.h,
                        ),
                        WorkItemScreenTextfield(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter width';
                              }
                              return null;
                            },
                            textfieldName: 'Width',
                            controller: _widthController),
                        SizedBox(
                          height: 1.h,
                        ),
                        WorkItemScreenTextfield(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter depth';
                              }
                              return null;
                            },
                            textfieldName: 'Depth',
                            controller: _depthController),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        Divider(
                          color: greyColor.withOpacity(0.2),
                        ),

                        /// check box along with text
                        Row(
                          children: [
                            Checkbox(
                              activeColor: blueColor,
                              focusColor: blueColor,
                              value: _isReworkChecked,
                              onChanged: (value) {
                                if (value != null) {
                                  /// Emit event to BLoC to toggle checkbox state
                                  addWorkItemScreenBlocOne.add(
                                      CheckBoxClickEvent(
                                          isChecked: value,
                                          fieldName: 'Rework'));
                                }
                              },
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

                        /// widget to build drop down
                        _buildDropDownWidget(
                            textfieldName: 'Flag Raised by',
                            hintText: 'Select Client',
                            list: clientsList,
                            dropDownController: _flagRaisedController),

                        /// checkbox alog with text
                        Row(
                          children: [
                            Checkbox(
                              activeColor: blueColor,
                              focusColor: blueColor,
                              value: _isFlagBillableChecked,
                              onChanged: (value) {
                                addWorkItemScreenBlocOne.add(CheckBoxClickEvent(
                                    isChecked: value!,
                                    fieldName: 'Flag Billable'));
                              },
                            ),
                            const Text('Is this rework flag billable?'),
                          ],
                        ),

                        Divider(
                          color: greyColor.withOpacity(0.2),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                subTotal,
                                overflow: TextOverflow.ellipsis,
                                style: CustomTextStyle.textStyle(
                                    fontSize: 12.spa,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            const Expanded(flex: 3, child: SizedBox()),
                            Expanded(
                              flex: 1,
                              child: Text(
                                '69.36 CY',
                                overflow: TextOverflow.ellipsis,
                                style: CustomTextStyle.textStyle(
                                    fontSize: 12.spa,
                                    color: greyColor,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                      ],
                    ),
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
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      title: Row(
        children: [
          Padding(
              padding: EdgeInsets.only(left: 3.w, right: 2.w),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context, true);
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: blueColor,
                  size: 20,
                ),
              )),
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
    return BlocConsumer(
      bloc: addWorkItemScreenBlocOne,
      buildWhen: (previous, current) => current is! AddWorkItemListnerState,
      listenWhen: (previous, current) => current is AddWorkItemListnerState,
      listener: (context, state) {
        switch (state.runtimeType) {
          case SaveAndAddButtonClickedState:
            Navigator.pop(context, true);

          case SaveButtonClickedState:
            _clearControllers();
            _formKey.currentState!.reset();
        }
      },
      builder: (context, state) {
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
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          mapData.addAll({
                            'description': _descriptionController.text,
                            'selectedDate': _dateController.text,
                            'defaultUnit': _defaultUnitsController.text,
                            "number": _numberController.text,
                            "length": _lengthController.text,
                            "width": _widthController.text,
                            "depth": _depthController.text,
                            'client': _flagRaisedController.text
                          });
                          addWorkItemScreenBlocOne
                              .add(SaveButtonClickedEvent(formData: mapData));
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.all(3.w),
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
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        mapData.addAll({
                          'description': _descriptionController.text,
                          'selectedDate': _dateController.text,
                          'defaultUnit': _defaultUnitsController.text,
                          "number": _numberController.text,
                          "length": _lengthController.text,
                          "width": _widthController.text,
                          "depth": _depthController.text,
                          'client': _flagRaisedController.text
                        });
                        addWorkItemScreenBlocOne.add(
                            SaveAndAddButtonClickedEvent(formData: mapData));
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(blueColor),
                        foregroundColor:
                            const WidgetStatePropertyAll(Colors.white),
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
      },
    );
  }

  /// Method to show calendar date picker
  void _showDatePicker() {
    /// Attempt to parse the existing date from the text field, if any
    DateTime? initialDate;

    if (_dateController.text.isNotEmpty) {
      try {
        /// Parsing the text date back to DateTime based on the format you used
        initialDate = DateFormat('LLL-dd-yyyy').parse(_dateController.text);
      } catch (e) {
        /// If parsing fails, fallback to the current date
        initialDate = DateTime.now();
      }
    } else {
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

              /// Use the parsed initial date (or current date if empty)
              value: [initialDate],
              onValueChanged: (dates) {
                if (dates.isNotEmpty) {
                  /// Format the selected date
                  String formattedDate =
                      DateFormat('LLL-dd-yyyy').format(dates[0]);

                  /// Set the formatted date to the date controller
                  _dateController.text = formattedDate;
                }
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    );
  }

  /// method to build dropdown
  Widget _buildDropDownWidget({
    required String textfieldName,
    required String hintText,
    required List<String> list,
    required TextEditingController dropDownController,
  }) {
    String? selectedValue =
        dropDownController.text.isNotEmpty ? dropDownController.text : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          textfieldName,
          style: CustomTextStyle.textStyle(
              fontSize: 15.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 1.h),
        DropdownButtonFormField2<String>(
            iconStyleData: IconStyleData(
                iconSize: 18,
                icon: Transform.rotate(
                  angle: 55,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: blueColor,
                    ),
                  ),
                )),
            dropdownStyleData: DropdownStyleData(
                decoration: BoxDecoration(color: skyBlueColor)),
            decoration: InputDecoration(
              suffixIcon: null,
              enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.zero),
                  borderSide:
                      BorderSide(width: 1.2, color: searchBarBorderColor)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.zero),
                  borderSide:
                      BorderSide(width: 1.2, color: searchBarBorderColor)),
              isDense: true,
              filled: true,
              fillColor: Colors.white,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 0.7.w, vertical: 1.25.h),
            ),
            hint: Text(
              hintText,
              style: CustomTextStyle.textStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: greyColor),
            ),
            value: selectedValue,
            items: list
                .map(
                  (unit) => DropdownMenuItem<String>(
                    value: unit,
                    child: Text(unit),
                  ),
                )
                .toList(),
            onChanged: (value) {
              selectedValue = value;
              dropDownController.text = value!;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: textfieldName == 'Flag Raised by'
                ? (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a unit';
                    }
                    return null;
                  }
                : null),
      ],
    );
  }

  /// method to clear controllers data
  void _clearControllers() {
    _descriptionController.clear();
    _dateController.clear();
    _defaultUnitsController.clear();
    _depthController.clear();
    _lengthController.clear();
    _widthController.clear();
    _flagRaisedController.clear();
    _numberController.clear();
  }
}
