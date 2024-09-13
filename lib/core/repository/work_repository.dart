class WorkRepository {
  // Private static instance of the class
  static final WorkRepository _instance = WorkRepository._internal();

  // Private constructor
  WorkRepository._internal();

  // Factory constructor to return the single instance
  factory WorkRepository() {
    return _instance;
  }

  final Map<int, Map<String, String>> _data = {};

  // Method to add data to the repository
  void addData(int index, Map<String, String> data) {
    // Clone the data to avoid external modifications
    _data[index] = Map.from(data);
  }

  // Method to get the data
  Map<int, Map<String, String>> getData() {
    // Return a clone to avoid external modifications
    return Map.unmodifiable(_data);
  }
}
