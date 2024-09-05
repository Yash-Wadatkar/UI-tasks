import 'package:ui_tasks/core/local_data/local_dfr_data.dart';

/// events for daily field report screen
sealed class DailyFieldReportEvent {}

/// open bottom model sheet event
class OpenBottomModelSheetEvent extends DailyFieldReportEvent {
  final bool ischecked;

  OpenBottomModelSheetEvent({required this.ischecked});
}

/// add DFR button clicked event
class AddDFRButtonClickedEvent extends DailyFieldReportEvent {
  final DfrData dfrData;

  AddDFRButtonClickedEvent({required this.dfrData});
}

/// event to select date from the calendar
class SelectDateEvent extends DailyFieldReportEvent {
  final DateTime selectedDate;
  final String field;

  SelectDateEvent(this.selectedDate, this.field);
}

/// event to open datepicker
class OpenDatePickerEvent extends DailyFieldReportEvent {
  final String textfieldName;

  OpenDatePickerEvent({required this.textfieldName});
}

/// event to toggle checkbox state
class ToggleCheckboxEvent extends DailyFieldReportEvent {
  final bool isChecked;

  ToggleCheckboxEvent({required this.isChecked});
}
