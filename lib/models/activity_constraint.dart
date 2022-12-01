import 'package:isar/isar.dart';

import 'activity_unit.dart';
import 'database.dart';
import 'property.dart';

part 'activity_constraint.g.dart';

/// Constraints that apply to individual [ActivityUnit]s.
@Collection()
class ActivityConstraint implements Data {
  @override
  int? id;

  /// A possible [Property] that is being constrained.
  ///
  /// If the link is empty, the threshold will represent number of time units.
  @Ignore()
  final property = IsarLink<Property>();

  /// What [ActivityUnit] this constraint applies to.
  @Ignore()
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
  @Ignore()
  final relation = IsarLink<ActivityUnit>();

  @override
  // TODO: implement copy
  Data get copy => throw UnimplementedError();

  @override
  // TODO: implement dataName
  String get dataName => throw UnimplementedError();

  @override
  // TODO: implement uniquenessHash
  int get uniquenessHash => throw UnimplementedError();
}
