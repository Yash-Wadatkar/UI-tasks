/// events of add items screen
sealed class AddItemsEvent {}

/// search event
class SearchEvent extends AddItemsEvent {
  final String query;

  SearchEvent({required this.query});
}
