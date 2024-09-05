import 'package:ui_tasks/core/local_data/local_dfr_data.dart';

/// states of daily field report screen
sealed class DailyFieldReportScreenState {}

/// listener state of daily field report screen
final class DailyFieldReportScreenListenerState
    extends DailyFieldReportScreenState {}

/// initial state of daily field report screen
class DailyFieldReportScreenInitialState extends DailyFieldReportScreenState {
  final List<DfrData>? dfrDataList;

  DailyFieldReportScreenInitialState({required this.dfrDataList});
}

/// listener state to open bottom model sheet
final class OpenBottomModelSheetState
    extends DailyFieldReportScreenListenerState {
  final bool ischecked;

  OpenBottomModelSheetState({required this.ischecked});
}

/// listener state to select date
final class SelectDateState extends DailyFieldReportScreenListenerState {
  final DateTime selectedDate;
  final String field;

  SelectDateState({required this.selectedDate, required this.field});
}

/// state to open date picker
final class OpenDatePickerState extends DailyFieldReportScreenListenerState {
  final String textfieldName;

  OpenDatePickerState({required this.textfieldName});
}

/// state for toggling checkbox
final class CheckboxToggledState extends DailyFieldReportScreenListenerState {
  final bool isChecked;

  CheckboxToggledState({required this.isChecked});
}
