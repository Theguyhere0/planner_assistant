import 'package:flutter/material.dart';

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

  const ProjectState({
    this.activityUnitName = '',
    this.activityUnitPluralName = '',
    this.timeUnitName = '',
    this.timeUnitPluralName = '',
  });

  ProjectState copyWith({
    String? activityUnitName,
    String? activityUnitPluralName,
    String? timeUnitName,
    String? timeUnitPluralName,
  }) {
    return ProjectState(
      activityUnitName: activityUnitName ?? this.activityUnitName,
      activityUnitPluralName:
          activityUnitPluralName ?? this.activityUnitPluralName,
      timeUnitName: timeUnitName ?? this.timeUnitName,
      timeUnitPluralName: timeUnitPluralName ?? this.timeUnitPluralName,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProjectState &&
        other.activityUnitName == activityUnitName &&
        other.activityUnitPluralName == activityUnitPluralName &&
        other.timeUnitName == timeUnitName &&
        other.timeUnitPluralName == timeUnitPluralName;
  }

  @override
  int get hashCode {
    return activityUnitName.hashCode ^
        activityUnitPluralName.hashCode ^
        timeUnitName.hashCode ^
        timeUnitPluralName.hashCode;
  }
}
