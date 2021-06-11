/// An exception thrown when something goes wrong related to the [FieldType.id] field.
class IdException implements Exception {
  String cause;
  IdException(this.cause);
}
