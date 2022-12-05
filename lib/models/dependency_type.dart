enum DependencyType {
  finishToStart('Predecessor must finish before this can start.'),
  finishToFinish('Predecessor must finish before this can finish.'),
  startToStart('Predecessor must start before this can start.'),
  startToFinish('Predecessor must start before this can finish.');

  final String value;

  const DependencyType(this.value);
}
