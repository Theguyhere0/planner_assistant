/// An exception thrown when something goes wrong related to a [Field] object.
class FieldException implements Exception {
  const FieldException(this.cause);

  /// The reason for this [Exception].
  final String cause;
}
