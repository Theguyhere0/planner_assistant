import 'field_settings.dart';

/// A data structure to hold a specific [Profile] configuration.
class Presets {
  /// The name of this [Presets].
  String name;

  /// The name for [Course] objects.
  String courseName;

  /// A list of [FieldSettings] objects.
  List<FieldSettings> fields;

  Presets({
    required this.name,
    required this.courseName,
    required this.fields,
  });
}
