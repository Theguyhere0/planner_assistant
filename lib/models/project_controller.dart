import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'activity_unit.dart';
import 'database.dart';
import 'label.dart';
import 'project_constraint.dart';
import 'project_state.dart';
import 'isar_service.dart';
import 'property.dart';
import 'property_type.dart';

final projectControllerProvider =
    StateNotifierProvider<ProjectController, ProjectState>((ref) {
  return ProjectController(
    ProjectState(
      bufferedProperty: Property.init(),
      bufferedLabel: Label.init(),
      bufferedActivityUnit: ActivityUnit(),
      bufferedProjectConstraint: ProjectConstraint(),
      properties: Database<Property>(
          validator: (e) => e.name.trim().isNotEmpty && e.type != null),
      labels: Database<Label>(
          validator: (e) =>
              e.name.trim().isNotEmpty && e.duration > 0 && e.start > 0),
      activityUnits: const AsyncData([]),
      projectConstraints: const AsyncData([]),
    ),
    ref.watch(isarServiceProvider),
  );
});

class ProjectController extends StateNotifier<ProjectState> {
  ProjectController(
    ProjectState state,
    this.isarService,
  ) : super(state);

  /// The service layer for the Isar database.
  final IsarService isarService;

  void updateActivityUnitName(String? updatedActivityUnitName) {
    state = state.copyWith(activityUnitName: updatedActivityUnitName);
  }

  void updateActivityUnitPluralName(String? updatedActivityUnitPluralName) {
    state =
        state.copyWith(activityUnitPluralName: updatedActivityUnitPluralName);
  }

  void updateTimeUnitName(String? updatedTimeUnitName) {
    state = state.copyWith(timeUnitName: updatedTimeUnitName);
  }

  void updateTimeUnitPluralName(String? updatedTimeUnitPluralName) {
    state = state.copyWith(timeUnitPluralName: updatedTimeUnitPluralName);
  }

  void resetBuffers() {
    state = state.copyWith(
      bufferedProperty: Property.init(),
      bufferedLabel: Label.init(),
      bufferedActivityUnit: ActivityUnit(),
      bufferedProjectConstraint: ProjectConstraint(),
    );
  }

  /// Attempt to load a specific [Property] to the buffer.
  void loadBufferedProperty(String name) {
    state = state.copyWith(
        bufferedProperty:
            state.properties.searchEntry((e) => e.name == name)?.copy ??
                Property.init());
  }

  /// Make some changes to the buffered [Property].
  void updateBufferedProperty({String? updatedName, String? updatedType}) {
    Property newProperty = state.bufferedProperty.copy;

    if (updatedName != null) {
      newProperty.name = updatedName;
    }
    if (updatedType != null) {
      newProperty.type = PropertyType.values
          .firstWhere((element) => element.value == updatedType);
    }

    state = state.copyWith(bufferedProperty: newProperty);
  }

  /// Checks to see if the buffered [Property] is valid.
  bool validateBufferedProperty() =>
      state.properties.validator(state.bufferedProperty);

  /// Saves the buffered [Property] to the database.
  void saveBufferedProperty() {
    state = state.copyWith(
        properties: state.properties..setEntry(state.bufferedProperty));
  }

  /// Removes the buffered [Property] from the database.
  void removeBufferedProperty() {
    state = state.copyWith(
        properties: state.properties..removeEntry(state.bufferedProperty));
  }

  /// Attempt to load a specific [Label] to the buffer.
  void loadBufferedLabel(String name) {
    state = state.copyWith(
        bufferedLabel: state.labels.searchEntry((e) => e.name == name)?.copy ??
            Label.init());
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

  /// Checks to see if the buffered [Property] is valid.
  bool validateBufferedLabel() => state.labels.validator(state.bufferedLabel);

  /// Saves the buffered [Property] to the database.
  void saveBufferedLabel() {
    state = state.copyWith(labels: state.labels..setEntry(state.bufferedLabel));
  }

  /// Removes the buffered [Property] from the database.
  void removeBufferedLabel() {
    state =
        state.copyWith(labels: state.labels..removeEntry(state.bufferedLabel));
  }
}
