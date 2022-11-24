import 'package:isar/isar.dart';

import 'data.dart';
import 'label.dart';
import 'property.dart';
import 'property_type.dart';

part 'project_constraint.g.dart';

/// Constraints that apply to the entire project.
@Collection()
class ProjectConstraint implements Data {
  int? id;

  /// A possible [Property] that is being constrained.
  ///
  /// If the link is empty, the threshold will represent number of [ActivityInstance]s.
  @Ignore()
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
  /// If the link is empty, the threshold will apply to each [TimeUnit]. Ignored if global is set to true.
  final label = IsarLink<Label>();

  @override
  String get dataName {
    String comparator =
        greaterThan == null ? 'Match' : (greaterThan! ? 'Over' : 'Under');
    String value;
    String units;
    Property? def = property.value;

    if (def == null) {
      value = intThreshold! as String;
      units = 'Activity Units';
    } else {
      units = def.name;
      switch (def.type!) {
        case PropertyType.string:
          value = stringThreshold!;
          break;
        case PropertyType.boolean:
          value = boolThreshold! as String;
          break;
        case PropertyType.integer:
          value = intThreshold! as String;
          break;
        case PropertyType.float:
          value = doubleThreshold! as String;
          break;
        case PropertyType.date:
        case PropertyType.time:
          value = timeThreshold! as String;
          break;
      }
    }

    return '$comparator $value $units';
  }

  @override
  String get dataType => 'Project Constraint';

  @override
  ProjectConstraint get copy => ProjectConstraint();
}
