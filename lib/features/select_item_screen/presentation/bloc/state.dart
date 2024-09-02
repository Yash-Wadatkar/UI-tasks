/// class for states of selected item screen
sealed class SelectItemState {}

class SelectItemScreenState extends SelectItemState {
  final List<String> filteredItemTableHeadingList;
  final List<String> selectedItems;

  SelectItemScreenState(
      {required this.selectedItems,
      required this.filteredItemTableHeadingList});
}
