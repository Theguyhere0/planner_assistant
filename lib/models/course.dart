import 'dart:convert';

import 'profile.dart';
import 'package:crypto/crypto.dart';

/// The basic unit of data for the Course Schedule Maker application.
///
/// Built to represent an academic course.
class Course {
  Course({required Profile profile}) {
    this.profile = profile;
    id = sha256.convert(utf8.encode(DateTime.now().toString())).toString();
  }

  /// The parent [Profile] to reference to.
  late final Profile profile;

  late final String id;

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
}
