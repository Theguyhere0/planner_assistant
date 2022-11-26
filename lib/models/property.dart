import 'data.dart';
import 'property_type.dart';

/// The definition for a property an [ActivityUnit] can have.
class Property implements Data {
  @override
  int? id;

  /// The name for this [Property].
  String name;

  /// The type of data this [Property] uses.
  PropertyType? type;

  Property({required this.name, this.type});

  Property.init() : name = '';

  @override
  String get dataName => name;

  @override
  String get dataType => 'Property';

  @override
  Property get copy => Property(name: name, type: type)..id = id;
}
