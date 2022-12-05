/// A custom class that acts like a database to better manage collections of [Data].
class Database<T extends Data> {
  final Map<int, T> _entries = {};
  int _nextAvailableId = 0;

  final bool Function(T entry) _validator;

  /// The function to validate the uniqueness of an entry.
  ///
  /// Returns true if the data entry is unique, otherwise returns false.
  bool validateUniqueness(T entry) => _entries.values.every((element) =>
      element.id == entry.id || element.uniquenessHash != entry.uniquenessHash);

  /// The function to validate each data entry before being added to the database. Includes checking for the uniqueness hash along with the custom validator.
  ///
  /// Returns true if the data entry is valid, otherwise returns false.
  bool validateEntry(T entry) => _validator(entry) && validateUniqueness(entry);

  /// Either insert a new entry or update an existing one. Returns true if the entry is new.
  bool setEntry(T entry) {
    bool result = entry.id == null;

    // Validate before accepting for further processing
    if (!validateEntry(entry)) {
      return false;
    }

    // Assign an id if null
    entry.id ??= _nextAvailableId++;

    // Place into database
    _entries[entry.id!] = entry;
    return result;
  }

  /// Attempt to insert all entries from one [Database] into another as a form of lazy initialization.
  void lazyInit(Database<T> database) {
    database.getAll().forEach((element) => setEntry(element));
    _nextAvailableId = database._nextAvailableId;
  }

  /// Get a list of all entries in this [Database].
  List<T> getAll() => _entries.values.toList();

  /// Get an entry by id. Returns null if none is found.
  T? getEntry(int id) => _entries[id];

  /// Get the first entry that fits the search criteria. Returns null if none is found.
  T? searchEntry(bool Function(T) search) =>
      _entries.values.any(search) ? _entries.values.firstWhere(search) : null;

  /// Make some changes to all entries of this [Database].
  void modifyEntries(void Function(T) modification) =>
      _entries.forEach((key, value) => modification(value));

  /// Removes a data entry from the [Database].
  void removeEntry(T entry) {
    _entries.remove(entry.id);
    entry.id = -1;
  }

  Database({bool Function(T)? validator})
      : _validator = validator ?? ((entry) => true);
}

/// A class that specifies how all "data" like classes behave.
abstract class Data {
  /// The unique identifier for this piece of data.
  int? id;

  /// The name for this piece of data.
  String get dataName;

  /// A hash to easily check for fields that should be unique for all pieces of data of this class.
  int get uniquenessHash;

  /// A copy of this piece of data.
  Data get copy;
}

/// A class of [Data] that has rank.
abstract class RankedData extends Data {
  /// The 1-based rank for this piece of data.
  int? rank;
}
