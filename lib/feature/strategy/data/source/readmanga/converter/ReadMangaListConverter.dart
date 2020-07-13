import 'package:html/dom.dart';
import 'package:manga/feature/firebase/use_case/FirebaseDatabaseUseCase.dart';
import 'package:manga/feature/strategy/data/model/MangaItem.dart';
import 'package:manga/feature/strategy/data/source/readmanga/ReadMangaStrategy.dart';
import 'package:manga/feature/strategy/utils/UriUtils.dart';
import 'package:manga/main.dart';

class ReadMangaListConverter {
  var _mangaUserUseCase = MyApp.injector.get<FirebaseDatabaseUseCase>();

  List<MangaItem> convert(Document body) {
    logger.d("start convert");
    var items = body.getElementsByClassName("col-sm-6");

    List<MangaItem> result = [];
    items.forEach((element) {
      var a = getUrl(element);
      var image = getImage(a);
      var desc = getDesc(element);
      if (a != null) {
        var url = a.attributes["href"].checkHttps(ReadMangaStrategy.host);
        var firebaseItem = _mangaUserUseCase.get(url);
        result.add(MangaItem(
            url,
            desc["name_rus"],
            desc["name_eng"],
            image.attributes["data-original"],
            firebaseItem?.isFavorite ?? false,
            firebaseItem?.chapterNumber ?? 0));
      }
    });
    logger.d("size: ${result.length}");
    return result;
  }

  Element getImage(Element a) {
    return a.children.first;
  }

  Element getUrl(Element item) {
    var a = item.getElementsByClassName("non-hover");
    if (a.isEmpty) return null;
    return a.first;
  }

  Map<String, String> getDesc(Element item) {
    var div = item.getElementsByClassName("desc");
    if (div.isEmpty) return null;
    var container = div.first;
    var result = <String, String>{};

    var title = container.getElementsByTagName("h3").first;
    result["name_rus"] = title.children.first.attributes["title"];

    var title2 = container.getElementsByTagName("h4");
    if (title2.length > 0) {
      result["name_eng"] = title2.first.attributes["title"];
    }

    return result;
  }
}
