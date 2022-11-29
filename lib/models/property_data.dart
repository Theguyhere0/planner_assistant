import 'package:flutter/material.dart';

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
  bool boolData;

  /// The double data stored.
  double? doubleData;

  /// The date data stored.
  late DateTime dateData;

  /// The time data stored.
  late TimeOfDay timeData;

  PropertyData({
    required this.property,
    required this.parent,
    this.intData,
    this.stringData,
    this.boolData = false,
    this.doubleData,
    DateTime? dateData,
    TimeOfDay? timeData,
  }) {
    this.dateData = dateData ?? DateTime.now();
    this.timeData = timeData ?? TimeOfDay.now();
  }

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
      case PropertyType.integer:
        return !property.mandatory || intData != null;
      case PropertyType.decimal:
        return !property.mandatory || doubleData != null;
      default:
        return true;
    }
  }
}
