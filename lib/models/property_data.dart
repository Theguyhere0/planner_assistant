import 'activity_unit.dart';
import 'property.dart';
import 'property_type.dart';

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

  /// Check if this [PropertyData] has a valid value. Deletes this from the parent [ActivityUnit] if the associated [Property] is no longer valid.
  bool get properlyFormed {
    // Delete if no longer valid and return true
    if (property.id! < 0) {
      parent.data.remove(this);
      return true;
    }

    // Check for valid value
    switch (property.type!) {
      case PropertyType.string:
        return !property.mandatory ||
            stringData != null && stringData!.isNotEmpty;
      case PropertyType.boolean:
        return !property.mandatory || boolData != null;
      case PropertyType.integer:
        return !property.mandatory || intData != null;
      case PropertyType.decimal:
        return !property.mandatory || doubleData != null;
      case PropertyType.date:
      case PropertyType.time:
        return !property.mandatory || timeData != null;
    }
  }
}
