import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planner_assistant/models/project_state.dart';

final projectControllerProvider =
    StateNotifierProvider.autoDispose<ProjectController, ProjectState>((ref) {
  return ProjectController(const ProjectState());
});

class ProjectController extends StateNotifier<ProjectState> {
  ProjectController(ProjectState state) : super(state);

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
}
