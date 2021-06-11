/// An exception thrown when something goes wrong related to the [FieldType.id] field.
class IdException implements Exception {
  const IdException(this.cause);

  /// The reason for this [Exception].
  final String cause;
}
