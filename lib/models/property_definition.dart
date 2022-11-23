import 'package:isar/isar.dart';

import '../utils/conversions.dart';
import 'data.dart';
import 'property_type.dart';

part 'property_definition.g.dart';

/// The definition for a property an [ActivityUnit] can have.
@Collection()
class PropertyDefinition implements Data {
  @Id()
  int get id => Conversions.fastHash(name);

  /// The name for this [PropertyDefinition].
  ///
  /// Must be unique because id hash depends on it.
  @Index(unique: true)
  late String name;

  /// The type of data this [PropertyDefinition] uses.
  @Index()
  late PropertyType type;

  @override
  String get dataName => name;

  @override
  String get dataType => 'Property';
}
