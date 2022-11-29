/// A class that specifies how all "data" like classes behave.
abstract class Data {
  /// The unique identifier for this piece of data.
  int? id;

  /// The name for this piece of data.
  String get dataName;

  /// A copy of this piece of data.
  Data get copy;
}
