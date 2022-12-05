import 'package:flutter/material.dart';

import 'property.dart';
import 'property_type.dart';

/// The data associated with a [Property] that a [PropertyDataHolder] has.
class PropertyData {
  /// What [Property] this data fulfills.
  final Property property;

  /// The class that holds [PropertyData] values.
  final PropertyDataHolder parent;

  /// The integer data stored.
  int? intData;

  /// The string data stored.
  String? stringData;

  /// The boolean data stored. Defaults to false.
  bool boolData;

  /// The double data stored.
  double? doubleData;

  /// The date data stored. Defaults to the date initialized.
  late DateTime dateData;

  /// The time data stored. Defaults to the time initialized.
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

  /// Check if this [PropertyData] has a valid value. Deletes this from the parent if the associated [Property] is no longer valid.
  bool get properlyFormed {
    // Delete if no longer valid and return true
    if (property.id! < 0) {
      parent.removePropertyData(this);
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

/// A class that specifies how classes that hold [PropertyData] should behave.
abstract class PropertyDataHolder {
  /// Removes this property data from the class.
  void removePropertyData(PropertyData propertyData);
}
