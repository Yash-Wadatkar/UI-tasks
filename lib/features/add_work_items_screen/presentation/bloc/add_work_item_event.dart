// events of add work item screen

sealed class AddWorkItemEvent {}

/// open calender event
class OpenCalenderEvent extends AddWorkItemEvent {}

/// check box click event
class CheckBoxClickEvent extends AddWorkItemEvent {}

/// open drop down event
class OpenDropDownEvent extends AddWorkItemEvent {}
