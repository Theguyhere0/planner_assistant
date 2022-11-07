import 'field_type.dart';
import 'course.dart';
import 'package:json_annotation/json_annotation.dart';

// part 'field.g.dart';

/// An object to store data from every [Course] about a specific field.
@JsonSerializable()
class Field {
  Field({
    required this.name,
    required this.fieldType,
    this.requiredField = false,
  });

  /// The name to call the corresponding [Field] instance.
  String name;

  /// The [FieldType] of the corresponding [Field] instance.
  FieldType fieldType;

  /// A flag indicating whether this [Field] is required or not.
  bool requiredField;

  /// The database for field data of each [Course].
  Map<Course, dynamic> database = {};

  // factory Field.fromJson(Map<String, dynamic> data) => _$FieldFromJson(data);

  // Map<String, dynamic> toJson() => _$FieldToJson(this);
}
