// events of add work item screen

sealed class AddWorkItemEvent {}

/// open calender event
class OpenCalenderEvent extends AddWorkItemEvent {}

/// check box click event
class CheckBoxClickEvent extends AddWorkItemEvent {
  final bool isChecked;
  final String fieldName;

  CheckBoxClickEvent({required this.fieldName, required this.isChecked});
}

/// open drop down event
class OpenDropDownEvent extends AddWorkItemEvent {}

/// event for selecting item from drop down
class SelectValueEvent extends AddWorkItemEvent {
  final String value;
  final String fieldName;

  SelectValueEvent({required this.fieldName, required this.value});
}

/// save and add button click event
class SaveAndAddButtonClickedEvent extends AddWorkItemEvent {
  final Map<String, String> formData;

  SaveAndAddButtonClickedEvent({required this.formData});
}

/// save button clicked state
class SaveButtonClickedEvent extends AddWorkItemEvent {
  final Map<String, String> formData;

  SaveButtonClickedEvent({required this.formData});
}

/// event to rebuild description textfield
class DescriptionChangedEvent extends AddWorkItemEvent {}
