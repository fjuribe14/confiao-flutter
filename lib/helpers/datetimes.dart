import 'package:intl/intl.dart';

//
// Clase para el manejo de fechas y tiempo
//
class DateTimes {
  DateTime now = DateTime.now();

  get nowInFormatyyyyMMddHHmmss =>
      DateFormat("yyyyMMddHHmmss").format(now).toString();

  nowInFormat(format) => DateFormat(format).format(now).toString();

  get nowInFormatXML => now
      .toString()
      .split(' ')
      .join('T'); //DateFormat("yyyy-MM-ddTH:mm:ss.SS").format(_now).toString();

  get nowInFormatJSON =>
      DateFormat("yyyy-MM-ddTHH:mm:ss").format(now).toString();

  get nowInFormatyyyyDashMMDashdd =>
      DateFormat("yyyy-MM-dd").format(now).toString();

  dateInFormat(String format, DateTime date) =>
      DateFormat(format, 'es').format(date);

  stringInDate(String date) => DateTime.parse(date);

  DateTime fromMillisecondsSinceEpoch(int time) =>
      DateTime.fromMillisecondsSinceEpoch(time);
}
