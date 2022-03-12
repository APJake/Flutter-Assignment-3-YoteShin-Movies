import 'package:intl/intl.dart';
import 'package:yoteshin_movies_asm/models/video.dart';

class UseMe {
  static Video getTrailerVideo(List<Video> videos) {
    for (Video v in videos) {
      if (v.name.toLowerCase().contains("trailer")) return v;
    }
    return videos[0];
  }

  static String getPrettyDate(DateTime dateTime) {
    DateFormat dateFormat = DateFormat("MMMM dd,yyyy");
    return dateFormat.format(dateTime);
  }
}
