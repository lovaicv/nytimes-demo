import 'package:intl/intl.dart';

showLog(dynamic message, {String? tag}) {
  printWrapped('$message');
}

printWrapped(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String convertDateFormat(String dateTime) {
  return myDateFormat().format(DateFormat('yyyy-MM-dd').parse(dateTime));
}

DateFormat myDateFormat() {
  return DateFormat('dd MMM yyyy');
}
