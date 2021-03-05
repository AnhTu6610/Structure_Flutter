import 'package:intl/intl.dart';

String moneyFormat(num number) {
  return "${NumberFormat("###,###,###,###").format(number)}";
}

String dateTimeFormatByString(String dateTime) {
  return DateFormat(" mm:hh dd/MM/yyyy").format(DateTime.tryParse(dateTime));
}

String dateTimeFormatByDateTime(DateTime dateTime) {
  return DateFormat("mm:hh dd/MM/yyyy").format(dateTime);
}
