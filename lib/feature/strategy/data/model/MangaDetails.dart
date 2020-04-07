
import 'package:manga/feature/strategy/data/model/Chapter.dart';

class MangaDetail {

  String name;
  String subname;
  String imageThumb;
  String imageFull;
  String rate;
  String description;
  bool isOngoing;
  List<String> genres;
  String year;
  String url;
  List<Chapter> chapters;

  MangaDetail({this.name, this.subname, this.imageThumb, this.imageFull, this.rate, this.description,
      this.isOngoing, this.genres, this.year, this.url, this.chapters});


}