// import 'exceptions/field_exception.dart';
// import 'exceptions/id_exception.dart';
// import 'field.dart';
// import 'field_type.dart';
// import 'field_settings.dart';
// import 'course.dart';
// import 'presets.dart';

// /// All data from the current session on the Course Schedule Maker application.
// class Profile {
//   Profile({
//     required this.name,
//     this.courseName = 'Course',
//     List<Field> fields = const [],
//   }) {
//     if (fields.isNotEmpty) setFields(fields);
//   }

//   /// The name of this [Profile].
//   String name;

//   /// The name for [Course] objects.
//   String courseName;

//   /// A list of [Field] objects.
//   var _fields = [
//     Field(
//       name: 'Course Id',
//       fieldType: FieldType.id,
//       requiredField: true,
//     ),
//     Field(
//       name: 'Course Name',
//       fieldType: FieldType.string,
//       requiredField: false,
//     ),
//   ];

//   /// A list of [Course] objects.
//   List<Course> courses = [];

//   /// A safe way to retrieve values from a [Field].
//   dynamic getFieldValue({
//     required Course course,
//     required String fieldName,
//   }) {
//     if (_fields.any((field) => field.name == fieldName))
//       throw FieldException('No such field name!');
//     return _fields
//         .firstWhere((field) => field.name == fieldName)
//         .database[course];
//   }

//   /// A safe way to update values in a [Field].
//   void setFieldValue({
//     required Course course,
//     required String fieldName,
//     required dynamic fieldValue,
//   }) {
//     if (_fields.any((field) => field.name == fieldName))
//       throw FieldException('No such field name!');
//     _fields.firstWhere((field) => field.name == fieldName).database[course] =
//         fieldValue;
//   }

//   /// A safe way to update [_fields] with a new list of all [Field] objects.
//   ///
//   /// Throws [IdException] if the proposed map doesn't include a [FieldType.id] field or if the proposed list includes more than one
//   /// [FieldType.id] field.
//   void setFields(List<Field> _fields) {
//     if (!_fields.contains(FieldType.id))
//       throw IdException('One field with type FieldType.id must be included!');
//     else if (_fields.where((field) => field.fieldType == FieldType.id).length >
//         1)
//       throw IdException('Only one field with type FieldType.id can exist!');
//     this._fields = _fields;
//   }

//   /// Creates a [Presets] from data of this [Profile].
//   Presets createPreset(String name) {
//     return Presets(
//       name: name,
//       courseName: courseName,
//       fields: _fields
//           .map(
//             (e) => FieldSettings(
//                 name: e.name,
//                 fieldType: e.fieldType,
//                 requiredField: e.requiredField),
//           )
//           .toList(),
//     );
//   }
// }
