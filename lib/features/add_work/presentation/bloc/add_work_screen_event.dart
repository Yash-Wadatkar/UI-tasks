// events of add work screen class

sealed class AddWorkScreenEvent {}

/// open calender event
class OpenCalenderEvent extends AddWorkScreenEvent {
  final int index;

  OpenCalenderEvent({required this.index});
}

/// add work event
class AddWorkButtonClickedEvent extends AddWorkScreenEvent {}

/// event to rebuild screen
class RebuildAddWorkScreenEvent extends AddWorkScreenEvent {}
