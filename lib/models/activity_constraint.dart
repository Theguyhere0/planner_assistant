import 'package:isar/isar.dart';

import 'activity_unit.dart';
import 'property.dart';

part 'activity_constraint.g.dart';

/// Constraints that apply to individual [ActivityUnit]s.
@collection
class ActivityConstraint {
  Id id = Isar.autoIncrement;

  /// A possible [Property] that is being constrained.
  ///
  /// If the link is empty, the threshold will represent number of time units.
  final property = IsarLink<Property>();

  /// What [ActivityUnit] this constraint applies to.
  final parent = IsarLink<ActivityUnit>();

  /// The integer threshold to check against.
  int? intThreshold;

  /// The string threshold to check against.
  String? stringThreshold;

  /// The boolean threshold to check against.
  bool? boolThreshold;

  /// The double threshold to check against.
  double? doubleThreshold;

  /// The time threshold to check against.
  DateTime? timeThreshold;

  /// Whether the actual value should be greater than the threshold value. If null, it should match.
  bool? greaterThan;

  /// A possible relationship to another [ActivityUnit].
  final relation = IsarLink<ActivityUnit>();
}
