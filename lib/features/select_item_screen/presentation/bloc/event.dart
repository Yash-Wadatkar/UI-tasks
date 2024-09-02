/// class for events of select item screen
sealed class SelectItemScreenEvent {}

/// search event
class SelectItemScreenSearchEvent extends SelectItemScreenEvent {
  final String query;

  SelectItemScreenSearchEvent({required this.query});
}

/// check box toggle event
class ToggleItemSelectionEvent extends SelectItemScreenEvent {
  final String item;

  ToggleItemSelectionEvent({required this.item});
}
