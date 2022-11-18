import 'package:isar/isar.dart';

import 'activity_unit.dart';
import 'property.dart';

part 'property_data.g.dart';

/// The data associated with a property that an [ActivityUnit] has.
@collection
class PropertyData {
  Id id = Isar.autoIncrement;

  /// What [Property] this data fulfills.
  final property = IsarLink<Property>();

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

  /// What [ActivityUnit] this property data describes.
  final parent = IsarLink<ActivityUnit>();
}
