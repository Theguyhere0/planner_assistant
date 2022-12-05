enum ConstraintType {
  equal('Must Be'),
  greaterThan('Must Be Over'),
  greaterThanEqual('Must Be At Least'),
  lessThan('Must Be Under'),
  lessThanEqual('Must Be At Most'),
  notEqual('Must Not Be');

  final String value;

  const ConstraintType(this.value);
}
