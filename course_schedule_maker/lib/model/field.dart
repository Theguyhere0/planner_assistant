import 'field_type.dart';
import 'course.dart';

/// An object to store data from every [Course] about a specific field.
class Field {
  /// The name to call the corresponding [Field] instance.
  String name;

  /// The [FieldType] of the corresponding [Field] instance.
  FieldType fieldType;

  /// A flag indicating whether this [Field] is required or not.
  bool requiredField;

  /// The database for field data of each [Course].
  Map<Course, dynamic> database = {};

  Field({
    required this.name,
    required this.fieldType,
    this.requiredField = false,
  });
}
