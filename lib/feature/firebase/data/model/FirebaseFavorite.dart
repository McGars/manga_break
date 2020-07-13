
import 'package:manga/feature/strategy/data/model/MangaItem.dart';

class FavoriteBody {

  String url;
  String name;
  String image;
  bool isFavorite;
  int chapterNumber = 0;

  FavoriteBody.fromItem(MangaItem item) {
    url = item.url ?? this.url;
    name = item.name ?? this.name;
    image = item.image ?? this.image;
    isFavorite = item.isFavorite ?? this.isFavorite ?? false;
    chapterNumber = item.chapterNumber ?? this.chapterNumber ?? 0;
  }

  Map<String, dynamic> toJson() => {
    "url": url,
    "isFavorite": isFavorite,
    "name": name,
    "image": image,
    "chapterNumber": chapterNumber
  };

  FavoriteBody.fromJson(Map<String, dynamic> json) {
    url = json["url"];
    name = json["name"];
    image = json["image"];
    isFavorite = json["isFavorite"] ?? false;
    chapterNumber = json["chapterNumber"] ?? 0;
  }
}

class FaribaseFavorite{

  String id;
  FavoriteBody favoriteBody;

  FaribaseFavorite(this.id, this.favoriteBody);

  Map<String, dynamic> toJson() => {
    "$id": favoriteBody
  };

  FaribaseFavorite.fromJson(Map<String, dynamic> json) {
    id = json.keys.first;
    favoriteBody = FavoriteBody.fromJson(json[id]);
  }

}