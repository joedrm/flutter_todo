class NumberUtil {
  static double getNumByValueDouble(double? value, int fractionDigits) {
    if (value == null) return 0.0;
    String valueStr = value.toStringAsFixed(fractionDigits);
    return double.tryParse(valueStr) ?? 0.0;
  }
}
