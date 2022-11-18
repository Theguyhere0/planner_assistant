import 'package:isar/isar.dart' as isar;

import 'activity_constraint.dart';
import 'activity_instance.dart';
import 'activity_unit.dart';
import 'criteria.dart';
import 'label.dart';
import 'project_constraint.dart';
import 'property_data.dart';
import 'property.dart';

class IsarService {
  late Future<isar.Isar> db;

  IsarService() {
    db = isar.Isar.open(
      [
        ActivityConstraintSchema,
        ActivityInstanceSchema,
        ActivityUnitSchema,
        CriteriaSchema,
        LabelSchema,
        ProjectConstraintSchema,
        PropertyDataSchema,
        PropertySchema
      ],
      inspector: true,
    );
  }

  Future<void> saveActivityConstraint(
      ActivityConstraint newActivityConstraint) async {
    final isar = await db;
    isar.writeTxn(
        () async => await isar.activityConstraints.put(newActivityConstraint));
  }

  Future<List<ActivityConstraint>> getAllActivityConstraints() async {
    final isar = await db;
    return await isar.activityConstraints.where().findAll();
  }

  Stream<List<ActivityConstraint>> listenToActivityConstraints() async* {
    final isar = await db;
    yield* isar.activityConstraints.where().watch(fireImmediately: true);
  }

  Future<void> saveActivityInstance(
      ActivityInstance newActivityInstance) async {
    final isar = await db;
    isar.writeTxn(
        () async => await isar.activityInstances.put(newActivityInstance));
  }

  Future<void> saveActivityUnit(ActivityUnit newActivityUnit) async {
    final isar = await db;
    isar.writeTxn(() async => await isar.activityUnits.put(newActivityUnit));
  }

  Future<void> saveCriteria(Criteria newCriteria) async {
    final isar = await db;
    isar.writeTxn(() async => await isar.criterias.put(newCriteria));
  }

  Future<void> saveLabel(Label newLabel) async {
    final isar = await db;
    isar.writeTxn(() async => await isar.labels.put(newLabel));
  }

  Future<void> saveProjectConstraint(
      ProjectConstraint newProjectConstraint) async {
    final isar = await db;
    isar.writeTxn(
        () async => await isar.projectConstraints.put(newProjectConstraint));
  }

  Future<void> savePropertyData(PropertyData newPropertyData) async {
    final isar = await db;
    isar.writeTxn(() async => await isar.propertyDatas.put(newPropertyData));
  }

  Future<void> saveProperty(Property newProperty) async {
    final isar = await db;
    isar.writeTxn(() async => await isar.propertys.put(newProperty));
  }

  Future<void> clean() async {
    final isar = await db;
    await isar.writeTxn(() => isar.clear());
  }
}
