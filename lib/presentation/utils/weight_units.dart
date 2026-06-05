const double _poundsPerKilogram = 2.2046226218;

String unitSuffix(String unit) {
  return unit == 'LB' ? 'lb' : 'kg';
}

double displayWeight(double kilograms, String unit) {
  return unit == 'LB' ? kilograms * _poundsPerKilogram : kilograms;
}

double kilogramsFromInput(double value, String unit) {
  return unit == 'LB' ? value / _poundsPerKilogram : value;
}

String formatWeight(double kilograms, String unit) {
  return '${displayWeight(kilograms, unit).toStringAsFixed(1)} '
      '${unitSuffix(unit)}';
}
