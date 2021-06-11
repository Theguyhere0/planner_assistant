/// An exception thrown when something goes wrong related to a [Field] object.
class FieldException implements Exception {
  String cause;
  FieldException(this.cause);
}
