import 'package:event_management/model/event.dart';
import 'package:intl/intl.dart';

String formatDate(String dateString) {
  DateTime parsedDate = DateTime.parse(dateString);
  return DateFormat('MMM d, y').format(parsedDate);
}

double calculateAverageRating(List<Reviews> reviewsList) {
  double total = 0.0;
  for (Reviews review in reviewsList) {
    total += review.rating!;
  }
  return total / reviewsList.length;
}

String truncateText(String text, int length) {
  if (text.length > length) {
    return '${text.substring(0, length)}...';
  }
  return text;
}
