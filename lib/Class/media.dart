import 'package:tingo/Enum/genre_type.dart';
import 'package:tingo/Enum/media_type.dart';

class Media {
  String img;
  String name;
  GenreType genreType;
  MediaType mediaType;
  int? season;
  int episode;
  DateTime releaseDateUTC;

  Media({
    required this.name,
    required this.img,
    required this.genreType,
    required this.mediaType,
    required this.season,
    required this.episode,
    required this.releaseDateUTC,
  });
}
