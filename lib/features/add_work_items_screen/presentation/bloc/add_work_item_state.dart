// states of add work item screen

sealed class AddWorkItemState {}

/// listner state for add Work item screen
final class AddWorkItemListnerState extends AddWorkItemState {}

/// initial state of add work item screen

class AddWorkItemScreenInitialState extends AddWorkItemState {}

/// state for opening the calender
final class OpenCalenderSate extends AddWorkItemListnerState {}

/// state for checkbox click
final class CheckBoxClickState extends AddWorkItemListnerState {
  final bool isChecked;
  final String fieldName;

  CheckBoxClickState({required this.fieldName, required this.isChecked});
}

/// state for opening drop down
class OpenDropDownState extends AddWorkItemState {}

/// state for selecting value from drop down
final class SelectValueState extends AddWorkItemListnerState {
  final String value;
  final String fieldName;

  SelectValueState({required this.fieldName, required this.value});
}

/// save and add button clicked state
final class SaveAndAddButtonClickedState extends AddWorkItemListnerState {}
