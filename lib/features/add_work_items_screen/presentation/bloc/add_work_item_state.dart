// states of add work item screen

sealed class AddWorkItemState {}

/// listner state for add Work item screen
final class AddWorkItemListnerState extends AddWorkItemState {}

/// initial state of add work item screen

class AddWorkItemScreenInitialState extends AddWorkItemState {}

/// state for opening the calender
final class OpenCalenderSate extends AddWorkItemListnerState {}

/// state for checkbox click
class CheckBoxClickState extends AddWorkItemState {}

/// state for opening drop down
class OpenDropDownState extends AddWorkItemState {}
