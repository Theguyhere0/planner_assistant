import 'profile.dart';

/// The basic unit of data for the Course Schedule Maker application.
///
/// Built to represent an academic course.
class Course {
  /// The parent [Profile] to reference to.
  Profile profile;

  /// Retrieves the value of the specified [Field] for this [Course].
  dynamic getValue(String fieldName) {
    return profile.getFieldValue(
      course: this,
      fieldName: fieldName,
    );
  }

  /// Sets the value of the specified [Field] for this [Course].
  void setValue({
    required String fieldName,
    required dynamic fieldValue,
  }) {
    profile.setFieldValue(
      course: this,
      fieldName: fieldName,
      fieldValue: fieldValue,
    );
  }

  Course({required this.profile});
}
