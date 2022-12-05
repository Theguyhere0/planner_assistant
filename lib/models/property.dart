import 'activity_unit.dart';
import 'database.dart';
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

  @override
  String get dataName => name;

  @override
  int get uniquenessHash => dataName.hashCode;

  @override
  Property get copy => Property(
        name: name,
        type: type,
        mandatory: mandatory,
      )..id = id;
}
