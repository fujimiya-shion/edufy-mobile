import 'package:intl/intl.dart';

final NumberFormat _vndFormatter = NumberFormat.currency(
  locale: 'vi_VN',
  symbol: '₫',
  decimalDigits: 0,
);

String formatCurrency(num? value) {
  if (value == null) return '';
  return _vndFormatter.format(value);
}

String formatDate(DateTime? date) {
  if (date == null) return '';
  return '${date.day.toString().padLeft(2, '0')}/'
      '${date.month.toString().padLeft(2, '0')}/'
      '${date.year}';
}

String formatDateRange(DateTime? start, DateTime? end) {
  final startStr = formatDate(start);
  final endStr = formatDate(end);

  if (startStr.isNotEmpty && endStr.isNotEmpty) {
    return '$startStr - $endStr';
  }

  if (startStr.isNotEmpty) return startStr;
  if (endStr.isNotEmpty) return endStr;
  return '';
}
