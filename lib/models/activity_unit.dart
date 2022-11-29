import 'data.dart';
import 'property.dart';
import 'property_data.dart';
import 'activity_instance.dart';
import 'activity_constraint.dart';

/// The basic units of activity that a project needs to have planned.
class ActivityUnit implements Data {
  @override
  int? id;

  /// The name for this [ActivityUnit].
  String name;

  /// Whether multiple [ActivityInstance]s can exist for this [ActivityUnit].
  bool unique;

  /// How many time units this [ActivityUnit] will take up
  int duration;

  /// All the [PropertyData] corresponding to this [ActivityUnit].
  final data = <Property, PropertyData>{};

  /// All the [ActivityInstance]s corresponding to this [ActivityUnit].
  final instances = <ActivityInstance>[];

  /// All the [ActivityConstraint]s corresponding to this [ActivityUnit].
  final constraints = <ActivityConstraint>[];

  ActivityUnit({this.name = '', this.unique = true, this.duration = 1});

  @override
  String get dataName => name;

  @override
  ActivityUnit get copy =>
      ActivityUnit(name: name, unique: unique, duration: duration)
        ..data.addAll(data)
        ..instances.addAll(instances)
        ..constraints.addAll(constraints)
        ..id = id;
}
