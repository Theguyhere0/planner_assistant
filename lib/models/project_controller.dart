import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'activity_unit.dart';
import 'database.dart';
import 'label.dart';
import 'project_constraint.dart';
import 'project_state.dart';
import 'isar_service.dart';
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
      bufferedProjectConstraint: ProjectConstraint(),
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
      projectConstraints: const AsyncData([]),
    ),
    ref.watch(isarServiceProvider),
  );
});

/// A class that controls how state is updated and managed for this app.
class ProjectController extends StateNotifier<ProjectState> {
  ProjectController(
    ProjectState state,
    this.isarService,
  ) : super(state);

  /// The service layer for the Isar database.
  final IsarService isarService;

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
      bufferedProjectConstraint: ProjectConstraint(),
    );
  }

  /// Attempt to load a specific [Property] to the buffer.
  void loadBufferedProperty(String name) {
    state = state.copyWith(
        bufferedProperty:
            state.properties.searchEntry((e) => e.name == name)?.copy ??
                Property());
  }

  /// Make some changes to the buffered [Property].
  void updateBufferedProperty(
      {String? updatedName, String? updatedType, bool? updatedMandatory}) {
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
      state.properties.validator(state.bufferedProperty);

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
  bool validateBufferedLabel() => state.labels.validator(state.bufferedLabel);

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
      state.activityUnits.validator(state.bufferedActivityUnit) &&
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
}
