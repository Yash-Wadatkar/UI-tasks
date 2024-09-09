// states of add work screen
sealed class AddWorkScreenState {}

/// class for all listner states
final class AddWorkScreenListnerState extends AddWorkScreenState {}

/// initial state of class
class AddWorkScreenInitialState extends AddWorkScreenState {}

/// state to open calender
final class OpenCalenderState extends AddWorkScreenListnerState {
  final int index;

  OpenCalenderState({required this.index});
}
