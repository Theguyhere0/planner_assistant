enum StatisticType {
  count('Count'),
  sum('Sum'),
  mean('Average'),
  median('Median'),
  min('Minimum'),
  max('Maximum'),
  range('Range');

  final String value;

  const StatisticType(this.value);
}
