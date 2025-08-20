enum ConditionEnum {
  NEW(value: "new", label: "Novo"),
  USED(value: "used", label: "Usado");

  final String value;
  final String label;

  const ConditionEnum({
    required this.value,
    required this.label,
  });

  String getLabel() {
    return label;
  }
}