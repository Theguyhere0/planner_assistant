import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planner_assistant/models/property_definition.dart';

import 'activity_unit.dart';
import 'label.dart';
import 'project_constraint.dart';
import 'project_state.dart';
import 'isar_service.dart';

final projectControllerProvider =
    StateNotifierProvider<ProjectController, ProjectState>((ref) {
  return ProjectController(
    ProjectState(
      bufferedPropertyDefinition: PropertyDefinition()..name = '',
      bufferedLabel: Label(),
      bufferedActivityUnit: ActivityUnit(),
      bufferedProjectConstraint: ProjectConstraint(),
      propertyDefinitions: const AsyncData([]),
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
      bufferedPropertyDefinition: PropertyDefinition()..name = '',
      bufferedLabel: Label(),
      bufferedActivityUnit: ActivityUnit(),
      bufferedProjectConstraint: ProjectConstraint(),
    );
  }

  void updateBufferedPropertyDefinition({String? updatedName}) {
    if (updatedName != null) {
      state = state.copyWith(
          bufferedPropertyDefinition: state.bufferedPropertyDefinition
            ..name = updatedName);
    }
  }

  /// Checks to see if the buffered [PropertyDefinition] has a unique, non-empty name.
  bool validateBufferedPropertyDefinition() =>
      state.bufferedPropertyDefinition.name.isNotEmpty &&
      !state.propertyDefinitions
          .when(
              data: (data) => data,
              error: (error, stackTrace) => [],
              loading: () => [])
          .map((e) => e.name)
          .contains(state.bufferedPropertyDefinition.name);

  /// Saves the buffered [PropertyDefinition] to Isar.
  void saveBufferedPropertyDefinition() {
    isarService.savePropertyDefinition(state.bufferedPropertyDefinition);
    loadData();
  }

  Future<void> loadData() async {
    state = state.copyWith(
      propertyDefinitions: const AsyncValue.loading(),
      labels: const AsyncValue.loading(),
      activityUnits: const AsyncValue.loading(),
      projectConstraints: const AsyncValue.loading(),
    );
    state = state.copyWith(
      propertyDefinitions:
          AsyncValue.data(await isarService.getAllPropertyDefinitions()),
      labels: AsyncValue.data(await isarService.getAllLabels()),
      activityUnits: AsyncValue.data(await isarService.getAllActivityUnits()),
      projectConstraints:
          AsyncValue.data(await isarService.getAllProjectConstraints()),
    );
  }
}
