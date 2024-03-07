import '../constant/index.dart';

String formatNumber({
  required double num,
  bool short = false,
}) {
  if (short) {
    if (num.abs() < 1000) {
      return num.toStringAsFixed(2);
    } else if (num.abs() < BaseSize.million) {
      return _helpShort(BaseSize.kilo, BaseString.kilo, num);
    } else if (num.abs() < BaseSize.billion) {
      return _helpShort(BaseSize.million, BaseString.million, num);
    } else if (num.abs() < BaseSize.trillion) {
      return _helpShort(BaseSize.billion, BaseString.billion, num);
    } else if (num.abs() < BaseSize.quadrillion) {
      return _helpShort(BaseSize.trillion, BaseString.trillion, num);
    } else {
      return _helpShort(BaseSize.quadrillion, BaseString.quadrillion, num);
    }
  } else {
    if (num.abs() < 1000.00) return num.toStringAsFixed(2);
    final bool isNegative = num < 0;
    final numberString = num.abs().toInt().toString();
    final numberDigits = List.from(numberString.split(''));
    int index = numberDigits.length - 3;
    while (index > 0) {
      numberDigits.insert(index, ',');
      index -= 3;
    }
    if (isNegative) return '-${numberDigits.join()}.00';
    return '${numberDigits.join()}.00';
  }
}

String _helpShort(double size, String string, double num) {
  double number = num / size;
  return '${number.toStringAsFixed(number.truncateToDouble() == number ? 0 : 1)}$string';
}
