import 'package:isar/isar.dart';

import '../utils/conversions.dart';
import 'property_data.dart';
import 'activity_instance.dart';
import 'activity_constraint.dart';

part 'activity_unit.g.dart';

/// The basic units of activity that a project needs to have planned.
@collection
class ActivityUnit {
  Id get id => Conversions.fastHash(name);

  /// The name for this [ActivityUnit].
  ///
  /// Must be unique because id hash depends on it.
  @Index()
  late String name;

  /// Whether multiple [ActivityInstance]s can exist for this [ActivityUnit].
  late bool unique;

  /// How many time units this [ActivityUnit] will take up
  late int duration;

  /// All the [PropertyData] corresponding to this [ActivityUnit].
  @Backlink(to: 'parent')
  final data = IsarLinks<PropertyData>();

  /// All the [ActivityInstance]s corresponding to this [ActivityUnit].
  @Backlink(to: 'parent')
  final instances = IsarLinks<ActivityInstance>();

  /// All the [ActivityConstraint]s corresponding to this [ActivityUnit].
  final constraints = IsarLinks<ActivityConstraint>();
}
