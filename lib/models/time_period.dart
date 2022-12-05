import 'database.dart';

/// A way to categorize, group, and divide up time units.
class TimePeriod implements Data {
  @override
  int? id;

  /// The name for this [TimePeriod].
  String name;

  /// How many time units this [TimePeriod] spans.
  int duration;

  /// On what time unit this [TimePeriod] starts.
  int start;

  /// The time units after the previous instance of this [TimePeriod] ends before it repeats, if it does.
  int? period;

  TimePeriod({this.name = '', this.duration = 1, this.start = 1, this.period});

  @override
  String get dataName => name;

  @override
  int get uniquenessHash => dataName.hashCode;

  @override
  TimePeriod get copy => TimePeriod(
        name: name,
        duration: duration,
        start: start,
        period: period,
      )..id = id;
}
