import 'activity_unit.dart';
import 'property.dart';

/// The data associated with a property that an [ActivityUnit] has.
class PropertyData {
  /// What [Property] this data fulfills.
  final Property property;

  /// What [ActivityUnit] this property data describes.
  final ActivityUnit parent;

  /// The integer data stored.
  int? intData;

  /// The string data stored.
  String? stringData;

  /// The boolean data stored.
  bool? boolData;

  /// The double data stored.
  double? doubleData;

  /// The time data stored.
  DateTime? timeData;

  PropertyData({
    required this.property,
    required this.parent,
    this.intData,
    this.stringData,
    this.boolData,
    this.doubleData,
    this.timeData,
  });
}
