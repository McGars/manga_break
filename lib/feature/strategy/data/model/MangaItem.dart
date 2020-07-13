import 'package:manga/feature/firebase/data/model/FirebaseFavorite.dart';

class MangaItem {
  /*nullable*/
  String url;

  /*nullable*/
  String name;

  /*nullable*/
  String subname;

  /*nullable*/
  String image;

  /*nullable*/
  int chapterNumber;

  bool isFavorite;

  MangaItem(this.url, this.name, this.subname, this.image, this.isFavorite, this.chapterNumber);

  MangaItem.fromFavorite(FavoriteBody body) {
    this.url = body.url;
    this.name = body.name;
    this.image = body.image;
    this.chapterNumber = body.chapterNumber;
    this.isFavorite = body.isFavorite;
  }

}
