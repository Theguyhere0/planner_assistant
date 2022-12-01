import 'label.dart';
import 'property.dart';

/// Important metrics that are being optimized in the project.
class Criteria {
  int? id;

  /// Priority of this [Criteria].
  ///
  /// This must be unique
  int? rank;

  /// A possible [Property] that is being constrained.
  ///
  /// If the link is empty, the threshold will represent number of [ActivityInstance]s that start in the time period of evaluation.
  Property? property;

  /// The integer target to check against. Only useful for matching.
  int? intTarget;

  /// The string target to check against. Only useful for matching.
  String? stringTarget;

  /// The boolean target to check against. Only useful for matching.
  bool? boolTarget;

  /// The double target to check against. Only useful for matching.
  double? doubleTarget;

  /// The time target to check against. Only useful for matching.
  DateTime? timeTarget;

  /// Whether to maximize or minimize the actual value. If null, try to match the target value.
  bool? maximize;

  /// Whether this constraint applies to an entire project or a specific time frame.
  bool? global;

  /// A potential time [Label] to apply the constraint to.
  ///
  /// If the link is empty, the threshold will represent number of [ActivityInstance]s. Ignored if global is set to true.
  Label? label;
}
