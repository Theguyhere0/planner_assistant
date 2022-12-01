import 'package:planner_assistant/models/property_data.dart';

import '../utils/conversions.dart';
import 'constraint_type.dart';
import 'database.dart';
import 'label.dart';
import 'property_type.dart';

/// Constraints that apply to the entire project.
class ProjectConstraint implements Data, PropertyDataHolder {
  @override
  int? id;

  /// An optional name for this [ProjectConstraint].
  String? name;

  /// The threshold value to check against.
  PropertyData? threshold;

  /// The backup integer threshold to check against, which represents activity unit count.
  int backupThreshold;

  /// What constraint should be applied comparing the actual value to the threshold value. Boolean and string values will default to [ConstraintType.equal] if not [ConstraintType.notEqual].
  ConstraintType type;

  /// Whether this constraint applies to an entire project or a specific time frame.
  bool global;

  /// A potential time [Label] to apply the constraint to. If null, the threshold will apply to each [TimeUnit]. Ignored if global is set to true.
  Label? label;

  ProjectConstraint({
    this.name,
    this.threshold,
    this.backupThreshold = 0,
    this.type = ConstraintType.equal,
    this.global = true,
    this.label,
  });

  @override
  String get dataName {
    // Return name if the name is not null
    if (name != null && name!.isNotEmpty) {
      return name!;
    }

    // Create the default name with the constraint parameters
    dynamic value;
    String units;

    if (threshold == null) {
      value = backupThreshold;
      units = 'Activity Units';
    } else {
      units = threshold!.property.name;
      switch (threshold!.property.type!) {
        case PropertyType.string:
          value = threshold!.stringData;
          break;
        case PropertyType.boolean:
          value = threshold!.boolData;
          break;
        case PropertyType.integer:
          value = threshold!.intData;
          break;
        case PropertyType.decimal:
          value = threshold!.doubleData;
          break;
        case PropertyType.date:
          value = threshold!.dateData;
          break;
        case PropertyType.time:
          value = threshold!.timeData;
          break;
      }
    }

    return '$units ${type.value.toLowerCase()} ${value == null ? '__' : value.toString()} for ${global == true || label == null ? 'Project' : label!.name}';
  }

  @override
  int get uniquenessHash => Conversions.fastHash(dataName);

  @override
  ProjectConstraint get copy => ProjectConstraint(
        name: name,
        threshold: threshold,
        backupThreshold: backupThreshold,
        type: type,
        global: global,
        label: label,
      )..id = id;

  @override
  void removePropertyData(PropertyData propertyData) {
    threshold = null;
  }
}
