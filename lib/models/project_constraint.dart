import 'package:isar/isar.dart';

import 'label.dart';
import 'property.dart';

part 'project_constraint.g.dart';

/// Constraints that apply to the entire project.
@collection
class ProjectConstraint {
  Id id = Isar.autoIncrement;

  /// A possible [Property] that is being constrained.
  ///
  /// If the link is empty, the threshold will represent number of [ActivityInstance]s.
  final property = IsarLink<Property>();

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

  /// Whether this constraint applies to an entire project or a specific time frame.
  late bool global;

  /// A potential time [Label] to apply the constraint to.
  ///
  /// If the link is empty, the threshold will represent number of [ActivityInstance]s. Ignored if global is set to true.
  final label = IsarLink<Label>();
}
