import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planner_assistant/models/criterion.dart';

import 'activity_constraint.dart';
import 'activity_unit.dart';
import 'constraint_type.dart';
import 'database.dart';
import 'label.dart';
import 'project_constraint.dart';
import 'project_state.dart';
import 'property.dart';
import 'property_data.dart';
import 'property_type.dart';

/// The state provider for this app.
final projectControllerProvider =
    StateNotifierProvider<ProjectController, ProjectState>((ref) {
  return ProjectController(
    ProjectState(
      bufferedProperty: Property(),
      bufferedLabel: Label(),
      bufferedActivityUnit: ActivityUnit(),
      bufferedActivityConstraint: ActivityConstraint(),
      bufferedProjectConstraint: ProjectConstraint(),
      bufferedCriterion: Criterion(),
      properties: Database<Property>(
          validator: (e) => e.name.trim().isNotEmpty && e.type != null),
      labels: Database<Label>(
          validator: (e) =>
              e.name.trim().isNotEmpty && e.duration > 0 && e.start > 0),
      activityUnits: Database<ActivityUnit>(
          validator: (e) =>
              e.name.trim().isNotEmpty &&
              e.duration > 0 &&
              e.data.values.every((element) => element.properlyFormed)),
      projectConstraints: Database<ProjectConstraint>(
          validator: (e) =>
              (e.threshold?.properlyFormed ?? true) &&
              !(e.threshold != null &&
                  (e.threshold!.property.type! == PropertyType.boolean ||
                      e.threshold!.property.type! == PropertyType.string) &&
                  e.type != ConstraintType.equal &&
                  e.type != ConstraintType.notEqual)),
      criteria: Database<Criterion>(
          validator: (e) =>
              e.property == null ||
              e.property?.type! == PropertyType.integer ||
              e.property?.type! == PropertyType.decimal),
    ),
  );
});

/// A class that controls how state is updated and managed for this app.
class ProjectController extends StateNotifier<ProjectState> {
  ProjectController(
    ProjectState state,
  ) : super(state);

  /// Change the activity unit name.
  void updateActivityUnitName(String? updatedActivityUnitName) {
    state = state.copyWith(activityUnitName: updatedActivityUnitName);
  }

  /// Change the plural activity unit name.
  void updateActivityUnitPluralName(String? updatedActivityUnitPluralName) {
    state =
        state.copyWith(activityUnitPluralName: updatedActivityUnitPluralName);
  }

  /// Change the time unit name.
  void updateTimeUnitName(String? updatedTimeUnitName) {
    state = state.copyWith(timeUnitName: updatedTimeUnitName);
  }

  /// Change the plural time unit name.
  void updateTimeUnitPluralName(String? updatedTimeUnitPluralName) {
    state = state.copyWith(timeUnitPluralName: updatedTimeUnitPluralName);
  }

  /// Clear out the buffers.
  void resetBuffers() {
    state = state.copyWith(
      bufferedProperty: Property(),
      bufferedLabel: Label(),
      bufferedActivityUnit: ActivityUnit(),
      bufferedActivityConstraint: ActivityConstraint(),
      bufferedProjectConstraint: ProjectConstraint(),
      bufferedCriterion: Criterion(),
    );
  }

  /// Clear out the special [ActivityConstraint] buffer for a new one with the buffered [ActivityUnit] as the parent.
  void resetActivityConstraintBuffer() {
    state = state.copyWith(
        bufferedActivityConstraint:
            ActivityConstraint(parent: state.bufferedActivityUnit));
  }

  /// Attempt to load a specific [Property] to the buffer.
  void loadBufferedProperty(String name) {
    state = state.copyWith(
        bufferedProperty:
            state.properties.searchEntry((e) => e.name == name)?.copy ??
                Property());
  }

  /// Make some changes to the buffered [Property].
  void updateBufferedProperty({
    String? updatedName,
    String? updatedType,
    bool? updatedMandatory,
  }) {
    Property newProperty = state.bufferedProperty.copy;

    if (updatedName != null) {
      newProperty.name = updatedName;
    }
    if (updatedType != null) {
      newProperty.type = PropertyType.values
          .firstWhere((element) => element.value == updatedType);
    }
    if (updatedMandatory != null) {
      newProperty.mandatory = updatedMandatory;
    }

    state = state.copyWith(bufferedProperty: newProperty);
  }

  /// Checks to see if the buffered [Property] is valid.
  bool validateBufferedProperty() =>
      state.properties.validateEntry(state.bufferedProperty);

  /// Saves the buffered [Property] to the database.
  void saveBufferedProperty() {
    // If the property is new, make sure all activity units get a dummy property data
    if (state.properties.setEntry(state.bufferedProperty)) {
      state.activityUnits.modifyEntries((e) {
        e.data[state.bufferedProperty] =
            PropertyData(property: state.bufferedProperty, parent: e);
      });
    }

    state = state.copyWith(properties: state.properties);
  }

  /// Removes the buffered [Property] from the database.
  void removeBufferedProperty() {
    state = state.copyWith(
        properties: state.properties..removeEntry(state.bufferedProperty));
  }

  /// Attempt to load a specific [Label] to the buffer.
  void loadBufferedLabel(String name) {
    state = state.copyWith(
        bufferedLabel:
            state.labels.searchEntry((e) => e.name == name)?.copy ?? Label());
  }

  /// Make some changes to the buffered [Label].
  void updateBufferedLabel({
    String? updatedName,
    int? updatedDuration,
    int? updatedStart,
    bool? periodOn,
    int? updatedPeriod,
  }) {
    Label newLabel = state.bufferedLabel.copy;

    if (updatedName != null) {
      newLabel.name = updatedName;
    }
    if (updatedDuration != null) {
      newLabel.duration = updatedDuration;
    }
    if (updatedStart != null) {
      newLabel.start = updatedStart;
    }
    if (periodOn != null) {
      if (periodOn) {
        newLabel.period = 0;
      } else {
        newLabel.period = null;
      }
    }
    if (updatedPeriod != null) {
      newLabel.period = updatedPeriod;
    }

    state = state.copyWith(bufferedLabel: newLabel);
  }

  /// Checks to see if the buffered [Label] is valid.
  bool validateBufferedLabel() =>
      state.labels.validateEntry(state.bufferedLabel);

  /// Saves the buffered [Label] to the database.
  void saveBufferedLabel() {
    state = state.copyWith(labels: state.labels..setEntry(state.bufferedLabel));
  }

  /// Removes the buffered [Label] from the database.
  void removeBufferedLabel() {
    state =
        state.copyWith(labels: state.labels..removeEntry(state.bufferedLabel));
  }

  /// Attempt to load a specific [ActivityUnit] to the buffer.
  void loadBufferedActivityUnit(String name) {
    state = state.copyWith(
        bufferedActivityUnit:
            state.activityUnits.searchEntry((e) => e.name == name)?.copy ??
                ActivityUnit());
  }

  /// Make some changes to the buffered [ActivityUnit].
  void updateBufferedActivityUnit({
    String? updatedName,
    bool? updatedUnique,
    int? updatedDuration,
    PropertyData? updatedPropertyData,
  }) {
    ActivityUnit newActivityUnit = state.bufferedActivityUnit.copy;

    if (updatedName != null) {
      newActivityUnit.name = updatedName;
    }
    if (updatedUnique != null) {
      newActivityUnit.unique = updatedUnique;
    }
    if (updatedDuration != null) {
      newActivityUnit.duration = updatedDuration;
    }
    if (updatedPropertyData != null) {
      newActivityUnit.data[updatedPropertyData.property] = updatedPropertyData;
    }

    state = state.copyWith(bufferedActivityUnit: newActivityUnit);
  }

  /// Checks to see if the buffered [ActivityUnit] is valid.
  bool validateBufferedActivityUnit() =>
      state.activityUnits.validateEntry(state.bufferedActivityUnit) &&
      state.properties.getAll().where((element) => element.mandatory).every(
          (element) => state.bufferedActivityUnit.data.containsKey(element));

  /// Saves the buffered [ActivityUnit] to the database.
  void saveBufferedActivityUnit() {
    state = state.copyWith(
        activityUnits: state.activityUnits
          ..setEntry(state.bufferedActivityUnit));
  }

  /// Removes the buffered [ActivityUnit] from the database.
  void removeBufferedActivityUnit() {
    state = state.copyWith(
        activityUnits: state.activityUnits
          ..removeEntry(state.bufferedActivityUnit));
  }

  /// Attempt to load a specific [ActivityConstraint] to the buffer, using the buffered [ActivityUnit] as the parent.
  void loadBufferedActivityConstraint(String name) {
    state = state.copyWith(
        bufferedActivityConstraint: state.bufferedActivityUnit.constraints
                .searchEntry((e) => e.dataName == name)
                ?.copy ??
            ActivityConstraint());
  }

  /// Make some changes to the buffered [ActivityConstraint].
  void updateBufferedActivityConstraint({
    String? updatedName,
    PropertyData? updatedThreshold,
    int? updatedBackupThreshold,
    String? updatedType,
    bool? updatedGlobal,
    Label? updatedLabel,
  }) {
    ActivityConstraint newActivityConstraint =
        state.bufferedActivityConstraint.copy;

    if (updatedName != null) {
      newActivityConstraint.name = updatedName;
    }
    if (updatedThreshold != null) {
      newActivityConstraint.threshold = updatedThreshold;
    }
    if (updatedBackupThreshold != null) {
      newActivityConstraint.threshold = null;
      newActivityConstraint.backupThreshold = updatedBackupThreshold;
    }
    if (updatedType != null) {
      newActivityConstraint.type = ConstraintType.values
          .firstWhere((element) => element.value == updatedType);
    }
    if (updatedGlobal != null) {
      newActivityConstraint.global = updatedGlobal;
    }
    if (updatedLabel != null) {
      newActivityConstraint.label = updatedLabel;
    }

    state = state.copyWith(bufferedActivityConstraint: newActivityConstraint);
  }

  /// Checks to see if the buffered [ActivityConstraint] is valid.
  bool validateBufferedActivityConstraint() =>
      state.bufferedActivityUnit.constraints
          .validateEntry(state.bufferedActivityConstraint);

  /// Saves the buffered [ActivityConstraint] to the buffered [ActivityUnit]'s database.
  void saveBufferedActivityConstraint() {
    state = state.copyWith(
        bufferedActivityUnit: state.bufferedActivityUnit
          ..constraints.setEntry(state.bufferedActivityConstraint));
  }

  /// Removes the buffered [ActivityConstraint] from the buffered [ActivityUnit]'s database.
  void removeBufferedActivityConstraint() {
    state = state.copyWith(
        bufferedActivityUnit: state.bufferedActivityUnit
          ..constraints.removeEntry(state.bufferedActivityConstraint));
  }

  /// Attempt to load a specific [ProjectConstraint] to the buffer.
  void loadBufferedProjectConstraint(String name) {
    state = state.copyWith(
        bufferedProjectConstraint: state.projectConstraints
                .searchEntry((e) => e.dataName == name)
                ?.copy ??
            ProjectConstraint());
  }

  /// Make some changes to the buffered [ProjectConstraint].
  void updateBufferedProjectConstraint({
    String? updatedName,
    PropertyData? updatedThreshold,
    int? updatedBackupThreshold,
    String? updatedType,
    bool? updatedGlobal,
    String? updatedLabel,
  }) {
    ProjectConstraint newProjectConstraint =
        state.bufferedProjectConstraint.copy;

    if (updatedName != null) {
      newProjectConstraint.name = updatedName;
    }
    if (updatedThreshold != null) {
      newProjectConstraint.threshold = updatedThreshold;
    }
    if (updatedBackupThreshold != null) {
      newProjectConstraint.threshold = null;
      newProjectConstraint.backupThreshold = updatedBackupThreshold;
    }
    if (updatedType != null) {
      newProjectConstraint.type = ConstraintType.values
          .firstWhere((element) => element.value == updatedType);
    }
    if (updatedGlobal != null) {
      newProjectConstraint.global = updatedGlobal;
    }
    if (updatedLabel != null) {
      newProjectConstraint.label = state.labels
          .getAll()
          .firstWhere((element) => element.dataName == updatedLabel);
    }

    state = state.copyWith(bufferedProjectConstraint: newProjectConstraint);
  }

  /// Checks to see if the buffered [ProjectConstraint] is valid.
  bool validateBufferedProjectConstraint() =>
      state.projectConstraints.validateEntry(state.bufferedProjectConstraint);

  /// Saves the buffered [ProjectConstraint] to the database.
  void saveBufferedProjectConstraint() {
    state = state.copyWith(
        projectConstraints: state.projectConstraints
          ..setEntry(state.bufferedProjectConstraint));
  }

  /// Removes the buffered [ProjectConstraint] from the database.
  void removeBufferedProjectConstraint() {
    state = state.copyWith(
        projectConstraints: state.projectConstraints
          ..removeEntry(state.bufferedProjectConstraint));
  }

  /// Attempt to load a specific [Criterion] to the buffer.
  void loadBufferedCriterion(String name) {
    state = state.copyWith(
        bufferedCriterion:
            state.criteria.searchEntry((e) => e.dataName == name)?.copy ??
                Criterion());
  }

  /// Make some changes to the buffered [Criterion].
  void updateBufferedCriterion({
    String? updatedName,
    int? updatedRank,
    String? updatedProperty,
    bool? updatedMaximize,
    bool? updatedGlobal,
    String? updatedLabel,
  }) {
    Criterion newCriterion = state.bufferedCriterion.copy;

    if (updatedName != null) {
      newCriterion.name = updatedName;
    }
    if (updatedRank != null) {
      newCriterion.rank = updatedRank;
    }
    if (updatedProperty != null) {
      newCriterion.property = state.properties
          .searchEntry((entry) => entry.dataName == updatedProperty);
    }
    if (updatedMaximize != null) {
      newCriterion.maximize = updatedMaximize;
    }
    if (updatedGlobal != null) {
      newCriterion.global = updatedGlobal;
    }
    if (updatedLabel != null) {
      newCriterion.label = state.labels
          .getAll()
          .firstWhere((element) => element.dataName == updatedLabel);
    }

    state = state.copyWith(bufferedCriterion: newCriterion);
  }

  /// Performs reordering of all the [Criterion].
  void reOrderCriteria(int oldRank, int newRank) {
    Criterion reOrdered =
        state.criteria.searchEntry((criterion) => criterion.rank! == oldRank)!;

    // Increase rank
    if (newRank > oldRank) {
      state.criteria
          .getAll()
          .where((criterion) =>
              criterion.rank! <= newRank && criterion.rank! > oldRank)
          .forEach((criterion) {
        state.criteria.setEntry(criterion..rank = criterion.rank! - 1);
      });
    }

    // Decrease rank
    else {
      state.criteria
          .getAll()
          .where((criterion) =>
              criterion.rank! >= newRank && criterion.rank! < oldRank)
          .forEach((criterion) {
        state.criteria.setEntry(criterion..rank = criterion.rank! + 1);
      });
    }

    /// Make changes
    state.criteria.setEntry(reOrdered..rank = newRank);
    state = state.copyWith();
  }

  /// Checks to see if the buffered [Criterion] is valid.
  bool validateBufferedCriterion() =>
      state.criteria.validateEntry(state.bufferedCriterion);

  /// Saves the buffered [Criterion] to the database.
  void saveBufferedCriterion() {
    state = state.copyWith(
        criteria: state.criteria..setEntry(state.bufferedCriterion));
  }

  /// Removes the buffered [Criterion] from the database.
  void removeBufferedCriterion() {
    state = state.copyWith(
        criteria: state.criteria..removeEntry(state.bufferedCriterion));
  }
}
