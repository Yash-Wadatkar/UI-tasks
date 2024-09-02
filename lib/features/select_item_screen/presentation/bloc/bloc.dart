import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_tasks/core/const/string_constants.dart';
import 'package:ui_tasks/features/select_item_screen/presentation/bloc/event.dart';
import 'package:ui_tasks/features/select_item_screen/presentation/bloc/state.dart';

/// bloc class for select item screen
class SelectItemScreenBloc
    extends Bloc<SelectItemScreenEvent, SelectItemState> {
  List<String> filteredItemTableHeadingList = [];
  List<String> selectedItems = [];
  SelectItemScreenBloc()
      : super(SelectItemScreenState(
          selectedItems: [],
          filteredItemTableHeadingList: itemsTableHeadings,
        )) {
    filteredItemTableHeadingList = List.from(itemsTableHeadings);

    /// event handler for search event
    on<SelectItemScreenSearchEvent>(selectItemScreenSearchEvent);

    /// event handler for checkbox event
    on<ToggleItemSelectionEvent>(toggleItemSelectionEvent);
  }

  FutureOr<void> selectItemScreenSearchEvent(
      SelectItemScreenSearchEvent event, Emitter emit) {
    if (event.query.isEmpty) {
      filteredItemTableHeadingList = List.from(itemsTableHeadings);
    } else {
      filteredItemTableHeadingList = itemsTableHeadings
          .where((heading) =>
              heading.toLowerCase().contains(event.query.toLowerCase()))
          .toList();
    }
    emit(SelectItemScreenState(
        filteredItemTableHeadingList: filteredItemTableHeadingList,
        selectedItems: selectedItems));
  }

  FutureOr<void> toggleItemSelectionEvent(
      ToggleItemSelectionEvent event, Emitter<SelectItemState> emit) {
    if (selectedItems.contains(event.item)) {
      selectedItems.remove(event.item);
    } else {
      selectedItems.add(event.item);
    }

    emit(SelectItemScreenState(
      filteredItemTableHeadingList: filteredItemTableHeadingList,
      selectedItems: selectedItems,
    ));
  }
}
