import 'package:html/dom.dart';
import 'package:manga/feature/strategy/data/model/MangaItem.dart';
import 'package:manga/feature/strategy/data/source/readmanga/ReadMangaStrategy.dart';
import 'package:manga/feature/strategy/utils/UriUtils.dart';
import 'package:manga/main.dart';

class ReadMangaListConverter {

  List<MangaItem> convert(Document body) {
    logger.d("start convert");
    var items = body.getElementsByClassName("col-sm-6");

    List<MangaItem> result = [];
    items.forEach((element) {
      var a = getUrl(element);
      var image = getImage(a);
      var desc = getDesc(element);
      if (a != null) {
        result.add(MangaItem (
            a.attributes["href"].checkHttps(ReadMangaStrategy.host),
            desc["name_rus"],
            desc["name_eng"],
            image.attributes["data-original"])
        );
      }
    });
    logger.d("size: ${ result.length}");
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
