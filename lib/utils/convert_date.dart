import 'package:intl/intl.dart';

class ConvertDate {
  final String date;

  ConvertDate(this.date);
  String convertISOToDateTimeHour() {
    var inputDate = DateTime.parse(date);
    var outputFormat = DateFormat('dd/MM/yyyy hh:mm a');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

  String convertISOToHour() {
    var inputDate = DateTime.parse(date);
    var outputFormat = DateFormat('HH:mm a');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }
  String convertISOToHourNoA() {
    var inputDate = DateTime.parse(date);
    var outputFormat = DateFormat('HH:mm');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }
  String convertISOToDateTime() {
    var inputDate = DateTime.parse(date);
    var outputFormat = DateFormat('dd/MM/yyyy');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }
}
