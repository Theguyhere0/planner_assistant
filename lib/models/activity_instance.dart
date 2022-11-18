import 'package:isar/isar.dart';

import 'activity_unit.dart';

part 'activity_instance.g.dart';

/// An instance of an [ActivityUnit] to put in a plan.
@collection
class ActivityInstance {
  Id id = Isar.autoIncrement;

  /// The [ActivityUnit] that was instantiated.
  final parent = IsarLink<ActivityUnit>();

  /// The time units that this [ActivityInstance] starts on.
  late int start;
}
