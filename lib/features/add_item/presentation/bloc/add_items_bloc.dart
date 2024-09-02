import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_tasks/core/const/string_constants.dart';
import 'package:ui_tasks/features/add_item/presentation/bloc/add_items_event.dart';
import 'package:ui_tasks/features/add_item/presentation/bloc/add_items_state.dart';

/// bloc class for add items screen

class AddItemsBloc extends Bloc<AddItemsEvent, AddItemsState> {
  /// declaring list of filtertable headings
  List<String> filteredTableHeadingList = [];
  AddItemsBloc()
      : super(SearchedState(filteredTableHeadingList: tableHeadingList)) {
    filteredTableHeadingList = List.from(tableHeadingList);

    /// event handler for search event
    on<SearchEvent>(searchEvent);
  }

  FutureOr<void> searchEvent(SearchEvent event, Emitter emit) {
    if (event.query.isEmpty) {
      filteredTableHeadingList = List.from(tableHeadingList);
    } else {
      filteredTableHeadingList = tableHeadingList
          .where((heading) =>
              heading.toLowerCase().contains(event.query.toLowerCase()))
          .toList();
    }
    emit(SearchedState(filteredTableHeadingList: filteredTableHeadingList));
  }
}
