enum PropertyType {
  string('String'),
  boolean('Boolean'),
  integer('Integer'),
  decimal('Decimal'),
  date('Date'),
  time('Time');

  final String value;

  const PropertyType(this.value);
}
