import 'activity_unit.dart';

/// An instance of an [ActivityUnit] to put in a plan.
class ActivityInstance {
  int? id;

  /// The [ActivityUnit] that was instantiated.
  ActivityUnit? parent;

  /// The time units that this [ActivityInstance] starts on.
  int? start;
}
