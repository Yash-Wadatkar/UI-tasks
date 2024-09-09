// events of add work screen class

sealed class AddWorkScreenEvent {}

/// open calender event
class OpenCalenderEvent extends AddWorkScreenEvent {
  final int index;

  OpenCalenderEvent({required this.index});
}
