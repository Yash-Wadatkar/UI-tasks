/// states of add item screen
sealed class AddItemsState {}

/// searched State
class SearchedState extends AddItemsState {
  final List<String> filteredTableHeadingList;

  SearchedState({required this.filteredTableHeadingList});
}
