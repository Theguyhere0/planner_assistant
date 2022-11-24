import 'data.dart';

/// A custom class that acts like a database to better manage collections of [Data].
class Database<T extends Data> {
  final Map<int, T> _entries = {};
  int _nextAvailableId = 0;

  /// The function to validate each data entry before being added to the database.
  ///
  /// Returns true if the data entry is valid, otherwise returns false.
  final bool Function(T entry) validator;

  /// Either insert a new entry or update an existing one. Returns false if the entry is not valid.
  bool setEntry(T entry) {
    // Validate before accepting for further processing
    if (!validator(entry)) {
      return false;
    }

    // Assign an id if null
    entry.id ??= _nextAvailableId++;

    // Place into database
    _entries[entry.id!] = entry;
    return true;
  }

  /// Get a list of all entries in this [Database].
  List<T> getAll() => _entries.values.toList();

  /// Get an entry by id. Returns null if none is found.
  T? getEntry(int id) => _entries[id];

  /// Get the first entry that fits the search criteria. Returns null if none is found.
  T? searchEntry(bool Function(T) search) =>
      _entries.values.any(search) ? _entries.values.firstWhere(search) : null;

  /// Removes a data entry from the [Database].
  void removeEntry(T entry) => _entries.remove(entry.id);

  Database({bool Function(T)? validator})
      : validator = validator ?? ((entry) => true);
}
