class ConverterService {
  static String doubleToString(double value) =>
      value == value.toInt() ? '${value.toInt()}' : '$value';
}
