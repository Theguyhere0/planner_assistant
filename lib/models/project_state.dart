import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'activity_unit.dart';
import 'database.dart';
import 'label.dart';
import 'project_constraint.dart';
import 'property.dart';

/// The top level metadata for a project.
@immutable
class ProjectState {
  /// The name for activity units in this project.
  final String activityUnitName;

  /// The plural variant of the name for activity units in this project.
  final String activityUnitPluralName;

  /// The name for time units in this project.
  final String timeUnitName;

  /// The plural variant of the name for time units in this project.
  final String timeUnitPluralName;

  /// A buffer for modifying a [Property] safely.
  final Property bufferedProperty;

  /// A buffer for modifying a [Label] safely.
  final Label bufferedLabel;

  /// A buffer for modifying an [ActivityUnit] safely.
  final ActivityUnit bufferedActivityUnit;

  /// A buffer for modifying a [ProjectConstraint] safely.
  final ProjectConstraint bufferedProjectConstraint;

  /// The database of all [Property]s for the project.
  final Database<Property> properties;

  /// Resolved [Label]s for the project
  final AsyncValue<List<Label>> labels;

  /// Resolved [ActivityUnit]s for the project
  final AsyncValue<List<ActivityUnit>> activityUnits;

  /// Resolved [ProjectConstraint]s for the project
  final AsyncValue<List<ProjectConstraint>> projectConstraints;

  const ProjectState({
    this.activityUnitName = '',
    this.activityUnitPluralName = '',
    this.timeUnitName = '',
    this.timeUnitPluralName = '',
    required this.bufferedProperty,
    required this.bufferedLabel,
    required this.bufferedActivityUnit,
    required this.bufferedProjectConstraint,
    required this.properties,
    required this.labels,
    required this.activityUnits,
    required this.projectConstraints,
  });

  ProjectState copyWith({
    String? activityUnitName,
    String? activityUnitPluralName,
    String? timeUnitName,
    String? timeUnitPluralName,
    Property? bufferedProperty,
    Label? bufferedLabel,
    ActivityUnit? bufferedActivityUnit,
    ProjectConstraint? bufferedProjectConstraint,
    Database<Property>? properties,
    AsyncValue<List<Label>>? labels,
    AsyncValue<List<ActivityUnit>>? activityUnits,
    AsyncValue<List<ProjectConstraint>>? projectConstraints,
  }) {
    return ProjectState(
      activityUnitName: activityUnitName ?? this.activityUnitName,
      activityUnitPluralName:
          activityUnitPluralName ?? this.activityUnitPluralName,
      timeUnitName: timeUnitName ?? this.timeUnitName,
      timeUnitPluralName: timeUnitPluralName ?? this.timeUnitPluralName,
      bufferedProperty: bufferedProperty ?? this.bufferedProperty,
      bufferedLabel: bufferedLabel ?? this.bufferedLabel,
      bufferedActivityUnit: bufferedActivityUnit ?? this.bufferedActivityUnit,
      bufferedProjectConstraint:
          bufferedProjectConstraint ?? this.bufferedProjectConstraint,
      properties: properties ?? this.properties,
      labels: labels ?? this.labels,
      activityUnits: activityUnits ?? this.activityUnits,
      projectConstraints: projectConstraints ?? this.projectConstraints,
    );
  }

  String get displayActivityUnitName => activityUnitName.trim().isEmpty
      ? 'Activity Unit'
      : activityUnitName.trim();

  String get displayActivityUnitPluralName =>
      activityUnitPluralName.trim().isEmpty
          ? '${displayActivityUnitName}s'
          : activityUnitPluralName.trim();

  String get displayTimeUnitName =>
      timeUnitName.trim().isEmpty ? 'Time Unit' : timeUnitName.trim();

  String get displayTimeUnitPluralName => timeUnitPluralName.trim().isEmpty
      ? '${displayTimeUnitName}s'
      : timeUnitPluralName.trim();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProjectState &&
        other.activityUnitName == activityUnitName &&
        other.activityUnitPluralName == activityUnitPluralName &&
        other.timeUnitName == timeUnitName &&
        other.timeUnitPluralName == timeUnitPluralName &&
        other.bufferedProperty == bufferedProperty &&
        other.bufferedLabel == bufferedLabel &&
        other.bufferedActivityUnit == bufferedActivityUnit &&
        other.bufferedProjectConstraint == bufferedProjectConstraint &&
        other.properties == properties &&
        other.labels == labels &&
        other.activityUnits == activityUnits &&
        other.projectConstraints == projectConstraints;
  }

  @override
  int get hashCode {
    return activityUnitName.hashCode ^
        activityUnitPluralName.hashCode ^
        timeUnitName.hashCode ^
        timeUnitPluralName.hashCode ^
        bufferedProperty.hashCode ^
        bufferedLabel.hashCode ^
        bufferedActivityUnit.hashCode ^
        bufferedProjectConstraint.hashCode ^
        properties.hashCode ^
        labels.hashCode ^
        activityUnits.hashCode ^
        projectConstraints.hashCode;
  }
}
