import 'package:isar/isar.dart';

import '../utils/conversions.dart';

part 'label.g.dart';

/// A way to categorize, group, and divide up time units.
@collection
class Label {
  Id get id => Conversions.fastHash(name);

  /// The name for this [Label].
  ///
  /// Must be unique because id hash depends on it.
  @Index()
  late String name;

  /// How many time units this [Label] spans.
  late int duration;

  /// On what time unit this [Label] starts.
  late int start;

  /// The time units after the first [Label] ends before it repeats, if it does.
  int? period;
}
