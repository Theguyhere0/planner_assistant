import 'activity_unit.dart';
import 'constraint_type.dart';
import 'database.dart';
import 'label.dart';
import 'property_data.dart';
import 'property_type.dart';

/// Constraints that apply to individual [ActivityUnit]s.
class ActivityConstraint implements Data, PropertyDataHolder {
  @override
  int? id;

  /// An optional name for this [ActivityConstraint].
  String? name;

  /// What [ActivityUnit] this constraint applies to.
  ActivityUnit? parent;

  /// The threshold value to check against.
  PropertyData? threshold;

  /// The backup integer threshold to check against, which represents time unit count.
  int backupThreshold;

  /// What constraint should be applied comparing the actual value to the threshold value.
  ConstraintType type;

  /// Whether this constraint applies to the entire plan or a specific time frame.
  bool global;

  /// A potential time [Label] to apply the constraint to.
  Label? label;

  ActivityConstraint({
    this.name,
    this.parent,
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
      units = 'Time Units';
    } else {
      units = threshold!.property.name;
      switch (threshold!.property.type!) {
        case PropertyType.integer:
          value = threshold!.intData;
          break;
        case PropertyType.decimal:
          value = threshold!.doubleData;
          break;
        default:
          value = 'INVALID';
      }
    }

    return '$units ${type.value.toLowerCase()} ${value == null ? '__' : value.toString()} for ${global == true || label == null ? 'Plan' : label!.name}';
  }

  @override
  int get uniquenessHash => dataName.hashCode;

  @override
  ActivityConstraint get copy => ActivityConstraint(
        name: name,
        parent: parent,
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
