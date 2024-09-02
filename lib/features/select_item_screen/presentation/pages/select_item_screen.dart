import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:ui_tasks/core/const/color_constant.dart';
import 'package:ui_tasks/core/const/custom_style_widget.dart';
import 'package:ui_tasks/core/const/string_constants.dart';
import 'package:ui_tasks/utils/search_bar_widget.dart';
import 'package:ui_tasks/features/select_item_screen/presentation/bloc/bloc.dart';
import 'package:ui_tasks/features/select_item_screen/presentation/bloc/event.dart';
import 'package:ui_tasks/features/select_item_screen/presentation/bloc/state.dart';
import 'package:ui_tasks/features/select_item_screen/presentation/widgets/select_item_card_widget.dart';
import 'package:ui_tasks/features/select_item_screen/presentation/widgets/suggested_item_card_widget.dart';

class SelectItemScreen extends StatefulWidget {
  const SelectItemScreen({super.key});

  @override
  State<SelectItemScreen> createState() => _SelectItemScreenState();
}

class _SelectItemScreenState extends State<SelectItemScreen> {
  /// creating instance of SelectItemScreenBloc
  final selectItemScreenBloc = SelectItemScreenBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 2.w, right: 2.w),
              child: Icon(
                Icons.arrow_back_ios,
                color: blueColor,
                size: 16,
              ),
            ),
            Text(
              addItem,
              style: CustomTextStyle.textStyle(
                  color: appBarTextColor,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
      backgroundColor: skyBlueColor,
      body: BlocConsumer(
        bloc: selectItemScreenBloc,
        listener: (context, state) {},
        builder: (context, state) {
          final selectItemState = state as SelectItemScreenState;
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 2.h),

                  /// search bar widget
                  SearchBarWidget(
                    onSearch: (query) {
                      /// adding search event
                      selectItemScreenBloc
                          .add(SelectItemScreenSearchEvent(query: query));
                    },
                  ),
                  SizedBox(height: 1.5.h),
                  Text(
                    suggestLineItemHeading,
                    overflow: TextOverflow.ellipsis,
                    style: CustomTextStyle.textStyle(
                        fontSize: 15.3.sp,
                        fontWeight: FontWeight.w600,
                        color: navBlueColor),
                  ),
                  SizedBox(height: 1.5.h),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: double.infinity, maxHeight: 4.h),
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(right: 4.w),
                          child: const SuggestedItemCardWidget(),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 2.h),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 61.7.h),
                    child: ListView.builder(
                      // physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount:
                          selectItemState.filteredItemTableHeadingList.length,
                      itemBuilder: (context, index) {
                        final item =
                            selectItemState.filteredItemTableHeadingList[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 2.h),
                          child: SelectItemCardWidget(
                            itemTableHeading: item,
                            isSelected:
                                selectItemState.selectedItems.contains(item),
                            onSelected: (isSelected) {
                              selectItemScreenBloc.add(
                                ToggleItemSelectionEvent(item: item),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BlocConsumer(
        bloc: selectItemScreenBloc,
        listener: (context, state) {},
        builder: (context, state) {
          final selectItemState = state as SelectItemScreenState;
          final selectedCount = selectItemState.selectedItems.length;
          return Container(
            width: double.infinity,
            height: 9.h,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  blurRadius: 2,
                  color: greyColor.withOpacity(0.2),
                  spreadRadius: 2,
                  offset: const Offset(-1, -2))
            ]),
            child: Row(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.5.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        selectedCount.toString().padLeft(2, '0'),
                        overflow: TextOverflow.ellipsis,
                        style: CustomTextStyle.textStyle(
                            fontWeight: FontWeight.w500, fontSize: 16.sp),
                      ),
                      SizedBox(
                        height: 0.2.h,
                      ),
                      Text(
                        itemSelected,
                        overflow: TextOverflow.ellipsis,
                        style: CustomTextStyle.textStyle(fontSize: 14.sp),
                      ),
                    ],
                  ),
                ),
                const Expanded(child: SizedBox()),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 5.w),
                  child: Column(
                    children: [
                      ElevatedButton(
                          style: const ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(Color(0xff246fb5)),
                              foregroundColor:
                                  WidgetStatePropertyAll(Colors.white),
                              shape: WidgetStatePropertyAll(
                                  ContinuousRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(0))))),
                          onPressed: () {},
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.w, vertical: 1.h),
                            child: Text(
                              addToDfr,
                              overflow: TextOverflow.ellipsis,
                              style: CustomTextStyle.textStyle(
                                  fontSize: 15.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ))
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
