import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_tasks/core/local_data/local_dfr_data.dart';
import 'daily_field_report_state.dart';
import 'daily_field_repost_event.dart';

class DailyFieldReportBloc
    extends Bloc<DailyFieldReportEvent, DailyFieldReportScreenState> {
  DailyFieldReportBloc()
      : super(DailyFieldReportScreenInitialState(dfrDataList: dfrList)) {
    /// event handler to open bottom model sheet
    on<OpenBottomModelSheetEvent>(openBottomModelSheetEvent);

    /// event handler for add dfr button clicked event
    on<AddDFRButtonClickedEvent>(addDFRButtonClickedEvent);

    /// event handler to open date picker
    on<OpenDatePickerEvent>(openDatePickerEvent);

    /// event handler for selecting date event
    on<SelectDateEvent>(selectDateEvent);

    on<ToggleCheckboxEvent>(toggleCheckboxEvent);
  }

  FutureOr<void> openBottomModelSheetEvent(
      OpenBottomModelSheetEvent event, Emitter emit) {
    emit(OpenBottomModelSheetState(ischecked: event.ischecked));
  }

  FutureOr<void> addDFRButtonClickedEvent(
      AddDFRButtonClickedEvent event, Emitter emit) {
    final List<DfrData> currentList = dfrList;

    currentList.add(event.dfrData);
    emit(DailyFieldReportScreenInitialState(dfrDataList: currentList));
  }

  FutureOr<void> selectDateEvent(
      SelectDateEvent event, Emitter<DailyFieldReportScreenState> emit) {
    emit(SelectDateState(
      selectedDate: event.selectedDate,
      field: event.field,
    ));
  }

  FutureOr<void> openDatePickerEvent(
      OpenDatePickerEvent event, Emitter<DailyFieldReportScreenState> emit) {
    emit(OpenDatePickerState(textfieldName: event.textfieldName));
  }

  FutureOr<void> toggleCheckboxEvent(
      ToggleCheckboxEvent event, Emitter<DailyFieldReportScreenState> emit) {
    emit(CheckboxToggledState(isChecked: event.isChecked));
  }
}
