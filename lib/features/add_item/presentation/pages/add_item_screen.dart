import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sizer/sizer.dart';
import 'package:ui_tasks/core/const/color_constant.dart';
import 'package:ui_tasks/core/const/custom_style_widget.dart';
import 'package:ui_tasks/core/const/string_constants.dart';
import 'package:ui_tasks/features/add_item/presentation/bloc/add_items_bloc.dart';
import 'package:ui_tasks/features/add_item/presentation/bloc/add_items_event.dart';
import 'package:ui_tasks/features/add_item/presentation/bloc/add_items_state.dart';
import 'package:ui_tasks/features/add_item/presentation/widgets/listview_card_widegt.dart';

import 'package:ui_tasks/utils/search_bar_widget.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  /// creating instance of AddItemBloc

  final addItemScreenBloc = AddItemsBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: skyBlueColor,
        title: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 3.w, right: 2.w),
              child: Icon(
                Icons.arrow_back_ios,
                color: blueColor,
                size: 16,
              ),
            ),
            Text(
              addItem,
              overflow: TextOverflow.ellipsis,
              style: CustomTextStyle.textStyle(
                  color: appBarTextColor,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),

      /// background color of screen
      backgroundColor: skyBlueColor,
      body: BlocConsumer(
        bloc: addItemScreenBloc,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          /// creating state variable for searched state
          final searchedState = state as SearchedState;
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 1.w),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pageHeading,
                          style: CustomTextStyle.textStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              color: navBlueColor),
                        ),
                        SizedBox(height: 2.h),

                        /// search bar widget
                        SearchBarWidget(
                          onSearch: (query) {
                            /// adding search event
                            addItemScreenBloc.add(SearchEvent(query: query));
                          },
                        ),
                        SizedBox(height: 2.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: .5.h),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.subdirectory_arrow_right_outlined,
                                size: 20,
                              ),
                              SizedBox(width: 1.2.h),
                              Text(
                                subGroupHeading,
                                style: CustomTextStyle.textStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(width: 1.2.h),
                              const Icon(
                                Icons.arrow_forward_outlined,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 2.h),

                        /// mediaquery widget to remove the by default top padding of listview
                        MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(maxHeight: 60.h),
                            child: ListView.builder(
                              //  physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount:
                                  searchedState.filteredTableHeadingList.length,
                              itemBuilder: (context, index) {
                                /// widget of listview card
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 5.w),
                                  child: ListviewCardWidegt(
                                    tableHeading: searchedState
                                        .filteredTableHeadingList[index],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        // const PopUpWidget(),
                        // SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar:

          /// wraping the add item button with container
          Container(
        width: double.infinity,
        height: 12.h,
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: 2.1.h, bottom: 4.h, left: 3.w, right: 3.w),

              /// outline button
              child: SizedBox(
                width: double.infinity,
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
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.w, vertical: 1.5.h),
                      child: Text(
                        addButtonText,
                        style: CustomTextStyle.textStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w600,
                            color: blueColor),
                      ),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
