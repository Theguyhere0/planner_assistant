import 'package:flutter/material.dart';

import '../widgets/common/card_tiles/decimal_field_card_tile.dart';
import '../widgets/common/card_tiles/integer_field_card_tile.dart';
import '../widgets/common/card_tiles/text_field_card_tile.dart';
import '../widgets/common/card_tiles/toggle_card_tile.dart';
import 'activity_unit.dart';
import 'data.dart';
import 'property_data.dart';
import 'property_type.dart';

/// The definition for a property an [ActivityUnit] can have.
class Property implements Data {
  @override
  int? id;

  /// The name for this [Property].
  String name;

  /// The type of data this [Property] uses.
  PropertyType? type;

  /// Whether this property is required for [ActivityUnit]s.
  bool mandatory;

  Property({
    this.name = '',
    this.type,
    this.mandatory = false,
  });

  /// Creates a card tile from the property for the activity unit.
  static Widget toWidget(
    Property property,
    ActivityUnit activityUnit,
    void Function(PropertyData) onChanged,
  ) {
    // Lazy initialize property data
    PropertyData data = activityUnit.data[property] ??
        PropertyData(property: property, parent: activityUnit);

    switch (property.type!) {
      case PropertyType.string:
        return TextFieldCardTile(
          property.name,
          hintText: 'Enter the ${property.name.toLowerCase()}',
          value: data.stringData,
          onChanged: (newValue) {
            data.stringData = newValue;
            onChanged(data);
          },
          validator: (value) {
            if (!property.mandatory || value!.trim().isNotEmpty) {
              return null;
            } else {
              return '${property.name} cannot be blank';
            }
          },
        );
      case PropertyType.boolean:
        return ToggleCardTile(
          property.name,
          offOption: 'No',
          onOption: 'Yes',
          value: data.boolData ?? false,
          onChanged: (newValue) {
            data.boolData = newValue;
            onChanged(data);
          },
        );
      case PropertyType.integer:
        return IntegerFieldCardTile(
          property.name,
          value: data.intData,
          onChanged: (newValue) {
            data.intData = int.tryParse(newValue);
            onChanged(data);
          },
          validator: (value) {
            if (property.mandatory && value!.isEmpty) {
              return 'Required';
            } else {
              return null;
            }
          },
        );
      case PropertyType.decimal:
        return DecimalFieldCardTile(
          property.name,
          value: data.doubleData,
          onChanged: (newValue) {
            data.doubleData = double.tryParse(newValue);
            onChanged(data);
          },
          validator: (value) {
            if (property.mandatory && value!.isEmpty) {
              return 'Required';
            } else {
              return null;
            }
          },
        );
      case PropertyType.date:
      case PropertyType.time:
        return const Text('Placeholder');
    }
  }

  @override
  String get dataName => name;

  @override
  Property get copy => Property(
        name: name,
        type: type,
        mandatory: mandatory,
      )..id = id;
}
