abstract class Data {
  /// The type of data that is present. Used when referring to what is being created, modified, or deleted.
  String get dataType;

  /// The name for the data instance.
  String get dataName;
}
