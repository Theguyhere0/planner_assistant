import 'package:flutter/material.dart';

import '../../../models/property.dart';
import '../../../models/property_data.dart';
import '../../../models/property_type.dart';
import 'date_picker_card_tile.dart';
import 'decimal_field_card_tile.dart';
import 'integer_field_card_tile.dart';
import 'text_field_card_tile.dart';
import 'time_picker_card_tile.dart';
import 'toggle_card_tile.dart';

/// A tile for custom cards with a field based on a [Property] for a [PropertyData] of a [PropertyDataHolder].
class PropertyCardTile extends StatelessWidget {
  /// Creates a card tile with a field based on a [Property] for a [PropertyData] of a [PropertyDataHolder].
  const PropertyCardTile({
    required this.property,
    required this.data,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  /// The [Property] that the card tile needs to be tailored for.
  final Property property;

  /// The [PropertyData] that will be updated by the card tile.
  final PropertyData data;

  /// What should happen when changes occur.
  final void Function(PropertyData) onChanged;

  @override
  Widget build(BuildContext context) {
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
          value: data.boolData,
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
        return DatePickerCardTile(
          property.name,
          value: data.dateData,
          onChanged: (newValue) {
            if (newValue != null) {
              data.dateData = newValue;
              onChanged(data);
            }
          },
        );
      case PropertyType.time:
        return TimePickerCardTile(
          property.name,
          value: data.timeData,
          onChanged: (newValue) {
            if (newValue != null) {
              data.timeData = newValue;
              onChanged(data);
            }
          },
        );
    }
  }
}
