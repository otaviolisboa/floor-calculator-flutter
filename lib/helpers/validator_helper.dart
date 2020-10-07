import 'parse_helper.dart';

class ValidatorHelper {
  static String isValidText(String text) {
    return text.isEmpty ? 'Campo obrigatório' : null;
  }
  static String isNegativeOrZero(String text) {
    var val = ParseHelper.toDouble(text);
    return val <= 0 ? 'Valor não pode ser menor ou igual a zero' : null;
  }
}
