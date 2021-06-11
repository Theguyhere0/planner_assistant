import 'field_type.dart';

/// An object to keep track of settings for their corresponding [Field] instance.
class FieldSettings {
  const FieldSettings({
    required this.name,
    required this.fieldType,
    required this.requiredField,
  });

  /// The name to call the corresponding [Field] instance.
  final String name;

  /// The [FieldType] of the corresponding [Field] instance.
  final FieldType fieldType;

  /// Whether the [Field] is required or not.
  final bool requiredField;
}
