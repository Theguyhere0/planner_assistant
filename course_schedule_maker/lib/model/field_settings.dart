import './field_type.dart';

/// An object to keep track of settings for their corresponding [Field] instance.
class FieldSettings {
  /// The name to call the corresponding [Field] instance.
  String name;

  /// The [FieldType] of the corresponding [Field] instance.
  FieldType fieldType;

  /// Whether the [Field] is required or not.
  bool requiredField;

  FieldSettings({
    required this.name,
    required this.fieldType,
    required this.requiredField,
  });
}
