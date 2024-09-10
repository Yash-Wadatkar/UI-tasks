import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sizer/sizer.dart';
import 'package:ui_tasks/core/const/color_constant.dart';
import 'package:ui_tasks/core/const/custom_style_widget.dart';
import 'package:ui_tasks/core/const/string_constants.dart';
import 'package:ui_tasks/features/add_work/presentation/bloc/add_work_screen_bloc.dart';
import 'package:ui_tasks/features/add_work/presentation/bloc/add_work_screen_event.dart';
import 'package:ui_tasks/features/add_work/presentation/bloc/add_work_screen_state.dart';
import 'package:ui_tasks/features/add_work/presentation/widgets/description_widget.dart';

import 'package:ui_tasks/features/add_work/presentation/widgets/expanding_card_widget.dart';
import 'package:ui_tasks/features/add_work_items_screen/presentation/pages/add_work_items_screen.dart';

class AddWorkScreen extends StatefulWidget {
  const AddWorkScreen({super.key});

  @override
  State<AddWorkScreen> createState() => _AddWorkScreenState();
}

class _AddWorkScreenState extends State<AddWorkScreen> {
  /// creating instance of add work screen bloc
  final addWorkScreenBloc = AddWorkScreenBloc();

  final Map<int, Map<String, String>> _data = {};

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
                        _data.isEmpty
                            ? Text(
                                'No Data Added Yet!',
                                style: CustomTextStyle.textStyle(
                                    fontSize: 14.spa,
                                    color: blueColor,
                                    fontWeight: FontWeight.w500),
                              )
                            : ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: _data.length,
                                itemBuilder: (context, index) {
                                  final Map<String, String> itemData =
                                      _data[index] ?? {};
                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 1.h),
                                    child: ExpandingCardWidget(
                                      date: itemData['selectedDate'] ??
                                          '', // Sending the value of 'date'
                                      depth: itemData['depth'] ??
                                          '', // Sending the value of 'depth'
                                      length: itemData['length'] ??
                                          '', // Sending the value of 'length'
                                      number: itemData['number'] ??
                                          '', // Sending the value of 'number'
                                      width: itemData['width'] ??
                                          '', // Sending the value of 'width'

                                      ontap: () {
                                        addWorkScreenBloc.add(
                                            OpenCalenderEvent(index: index));
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
    return BlocConsumer(
      bloc: addWorkScreenBloc,
      buildWhen: (previous, current) => current is! AddWorkScreenListnerState,
      listenWhen: (previous, current) => current is AddWorkScreenListnerState,
      listener: (context, state) {
        switch (state.runtimeType) {
          case AddWorkScreenButtonClickedState:
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return const AddWorkItemsScreen();
              },
            )).then((value) {
              if (value is Map<String, String>) {
                final int nextIndex = _data
                    .length; // Assuming new index is based on current length
                _data[nextIndex] =
                    value; // Assigning the received data to the next index
                print(_data.length);
                addWorkScreenBloc.add(RebuildAddWorkScreenEvent());
              }
            });
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
                        addWorkScreenBloc.add(AddWorkButtonClickedEvent());
                      },
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
                        foregroundColor:
                            const WidgetStatePropertyAll(Colors.white),
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
}
