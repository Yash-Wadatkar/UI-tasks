import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_tasks/core/repository/work_repository.dart';
import 'package:ui_tasks/features/add_work_items_screen/presentation/bloc/add_work_item_event.dart';
import 'package:ui_tasks/features/add_work_items_screen/presentation/bloc/add_work_item_state.dart';

class AddWorkItemBloc extends Bloc<AddWorkItemEvent, AddWorkItemState> {
  /// Instance of WorkRepository
  final WorkRepository workRepository;

  /// Constructor where you pass the workRepository
  AddWorkItemBloc({required this.workRepository})
      : super(AddWorkItemScreenInitialState()) {
    /// Event handler for open calendar event
    on<OpenCalenderEvent>(openCalenderEvent);

    /// Event handler for selecting value from drop down
    on<SelectValueEvent>(selectValueEvent);

    /// Event handler for check box click
    on<CheckBoxClickEvent>(checkBoxClickEvent);

    /// Event handler for save and add button click event
    on<SaveAndAddButtonClickedEvent>(saveAndAddButtonClickedEvent);

    /// Event handler for save button clicked event
    on<SaveButtonClickedEvent>(saveButtonClickedEvent);

    /// Event handler for description change
    on<DescriptionChangedEvent>(descriptionChangedEvent);
  }

  /// Calendar event handler
  FutureOr<void> openCalenderEvent(
      OpenCalenderEvent event, Emitter<AddWorkItemState> emit) {
    emit(OpenCalenderSate());
  }

  /// Dropdown value selection event handler
  FutureOr<void> selectValueEvent(
      SelectValueEvent event, Emitter<AddWorkItemState> emit) {
    emit(SelectValueState(value: event.value, fieldName: event.fieldName));
  }

  /// Checkbox click event handler
  FutureOr<void> checkBoxClickEvent(
      CheckBoxClickEvent event, Emitter<AddWorkItemState> emit) {
    emit(CheckBoxClickState(
        isChecked: event.isChecked, fieldName: event.fieldName));
    emit(AddWorkItemScreenInitialState());
  }

  /// Save and add button event handler
  FutureOr<void> saveAndAddButtonClickedEvent(
      SaveAndAddButtonClickedEvent event, Emitter<AddWorkItemState> emit) {
    final int nextIndex = workRepository.getData().length;

    /// Assuming that `formData` is passed via event to store it in the repository.
    workRepository.addData(nextIndex, event.formData);
    emit(SaveAndAddButtonClickedState());
  }

  /// Description changed event handler
  FutureOr<void> descriptionChangedEvent(
      DescriptionChangedEvent event, Emitter<AddWorkItemState> emit) {
    emit(DescriptionUpdatedState());
  }

  /// Save button clicked event handler
  FutureOr<void> saveButtonClickedEvent(
      SaveButtonClickedEvent event, Emitter<AddWorkItemState> emit) {
    final int nextIndex = workRepository.getData().length;

    /// Assuming that `formData` is passed via event to store it in the repository.
    workRepository.addData(nextIndex, event.formData);

    emit(SaveButtonClickedState());
  }
}
