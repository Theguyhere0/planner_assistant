import 'field_settings.dart';

/// A data structure to hold a specific [Profile] configuration.
class Presets {
  const Presets({
    required this.name,
    required this.courseName,
    required this.fields,
  });

  /// The name of this [Presets].
  final String name;

  /// The name for [Course] objects.
  final String courseName;

  /// A list of [FieldSettings] objects.
  final List<FieldSettings> fields;
}
