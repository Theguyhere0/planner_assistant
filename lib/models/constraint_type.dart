enum ConstraintType {
  equal('Is'),
  greaterThan('Is Over'),
  greaterThanEqual('Is At Least'),
  lessThan('Is Under'),
  lessThanEqual('Is At Most'),
  notEqual('Is Not');

  final String value;

  const ConstraintType(this.value);
}
