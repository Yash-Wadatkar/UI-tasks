// bloc of add work item screen

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_tasks/features/add_work_items_screen/presentation/bloc/add_work_item_event.dart';
import 'package:ui_tasks/features/add_work_items_screen/presentation/bloc/add_work_item_state.dart';

class AddWorkItemBloc extends Bloc<AddWorkItemEvent, AddWorkItemState> {
  AddWorkItemBloc() : super(AddWorkItemScreenInitialState()) {
    /// event handler for open calender event
    on<OpenCalenderEvent>(openCalenderEvent);

    /// event handler for selecting value from drop down
    on<SelectValueEvent>(selectValueEvent);

    /// event handler for check box
    on<CheckBoxClickEvent>(checkBoxClickEvent);

    /// event handler for save and add button click event
    on<SaveAndAddButtonClickedEvent>(saveAndAddButtonClickedEvent);
  }

  FutureOr<void> openCalenderEvent(
      OpenCalenderEvent event, Emitter<AddWorkItemState> emit) {
    emit(OpenCalenderSate());
  }

  FutureOr<void> selectValueEvent(
      SelectValueEvent event, Emitter<AddWorkItemState> emit) {
    emit(SelectValueState(value: event.value, fieldName: event.fieldName));
    emit(AddWorkItemScreenInitialState());
  }

  FutureOr<void> checkBoxClickEvent(
      CheckBoxClickEvent event, Emitter<AddWorkItemState> emit) {
    emit(CheckBoxClickState(
        isChecked: event.isChecked, fieldName: event.fieldName));

    emit(AddWorkItemScreenInitialState());
  }

  FutureOr<void> saveAndAddButtonClickedEvent(
      SaveAndAddButtonClickedEvent event, Emitter<AddWorkItemState> emit) {
    emit(SaveAndAddButtonClickedState());
  }
}
