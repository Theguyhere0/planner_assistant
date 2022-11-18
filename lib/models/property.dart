import 'package:isar/isar.dart';

import '../utils/conversions.dart';
import 'property_type.dart';

part 'property.g.dart';

/// A property for [ActivityUnit]s to have.
@collection
class Property {
  Id get id => Conversions.fastHash(name);

  /// The name for this [Property].
  ///
  /// Must be unique because id hash depends on it.
  @Index(unique: true)
  late String name;

  /// The type of data this [Property] uses.
  @Index()
  @enumerated
  late PropertyType type;
}
