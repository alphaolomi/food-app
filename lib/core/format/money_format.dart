import 'package:intl/intl.dart';

String formatMoneyCents(int cents) {
  return NumberFormat.currency(symbol: r'$', decimalDigits: 2).format(cents / 100.0);
}
