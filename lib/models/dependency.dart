import 'activity_unit.dart';
import 'database.dart';
import 'dependency_type.dart';

/// Dependencies that apply to individual [ActivityUnit]s.
class Dependency implements Data {
  @override
  int? id;

  /// An optional name for this [Dependency].
  String? name;

  /// What [ActivityUnit] this dependency applies to.
  ActivityUnit? parent;

  /// What the predecessor [ActivityUnit] is.
  ActivityUnit? predecessor;

  /// What type of dependency should apply to this [ActivityUnit] with respect to the predecessor.
  DependencyType type;

  Dependency({
    this.name,
    this.parent,
    this.predecessor,
    this.type = DependencyType.finishToStart,
  });

  @override
  String get dataName {
    // Return name if the name is not null
    if (name != null && name!.isNotEmpty) {
      return name!;
    }

    // Create the default name with the constraint parameters
    return type.value
        .replaceFirst('Predecessor', predecessor?.dataName ?? '')
        .replaceFirst('this', parent?.dataName ?? '');
  }

  @override
  int get uniquenessHash => dataName.hashCode;

  @override
  Dependency get copy => Dependency(
        name: name,
        parent: parent,
        predecessor: predecessor,
        type: type,
      )..id = id;
}
