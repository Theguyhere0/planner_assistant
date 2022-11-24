import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'activity_unit.dart';
import 'database.dart';
import 'label.dart';
import 'project_constraint.dart';
import 'project_state.dart';
import 'isar_service.dart';
import 'property.dart';

final projectControllerProvider =
    StateNotifierProvider<ProjectController, ProjectState>((ref) {
  return ProjectController(
    ProjectState(
      bufferedProperty: Property(name: ''),
      bufferedLabel: Label(),
      bufferedActivityUnit: ActivityUnit(),
      bufferedProjectConstraint: ProjectConstraint(),
      properties:
          Database<Property>(validator: (e) => e.name.trim().isNotEmpty),
      labels: const AsyncData([]),
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
  ) : super(state) {
    loadData();
  }

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
      bufferedProperty: Property(name: ''),
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
                Property(name: ''));
  }

  /// Make some changes to the buffered [Property].
  void updateBufferedPropertyDefinition(String? updatedName) {
    if (updatedName != null) {
      state = state.copyWith(
          bufferedProperty: state.bufferedProperty..name = updatedName);
    }
  }

  /// Checks to see if the buffered [Property] is valid.
  bool validateBufferedPropertyDefinition() =>
      state.properties.validator(state.bufferedProperty);

  /// Saves the buffered [Property] to the database.
  void saveBufferedPropertyDefinition() {
    state = state.copyWith(
        properties: state.properties..setEntry(state.bufferedProperty));
  }

  /// Removes the buffered [Property] from the database.
  void removeBufferedPropertyDefinition() {
    state = state.copyWith(
        properties: state.properties..removeEntry(state.bufferedProperty));
  }

  void loadData() async {
    state = state.copyWith(
      labels: const AsyncValue.loading(),
      activityUnits: const AsyncValue.loading(),
      projectConstraints: const AsyncValue.loading(),
    );
    state = state.copyWith(
      labels: AsyncValue.data(await isarService.getAllLabels()),
      activityUnits: AsyncValue.data(await isarService.getAllActivityUnits()),
      projectConstraints:
          AsyncValue.data(await isarService.getAllProjectConstraints()),
    );
  }
}
