import 'package:html/dom.dart';
import 'package:manga/feature/strategy/data/model/Chapter.dart';
import 'package:manga/feature/strategy/data/model/MangaDetails.dart';
import 'package:manga/feature/strategy/data/model/MangaItem.dart';
import 'package:manga/feature/strategy/data/source/readmanga/ReadMangaStrategy.dart';
import 'package:manga/feature/strategy/utils/UriUtils.dart';
import 'package:manga/main.dart';

class ReadMangaDetailConverter {

  MangaDetail convert(MangaItem mangaItem, Document body) {
    logger.d("start convert");

    var content = body
        .getElementsByClassName("leftContent")
        .first
        .getElementsByClassName("expandable")
        .first;

    var meta = content.getElementsByClassName("subject-meta").first;
    var image = getImage(content);

    return MangaDetail(
      name: mangaItem.name,
      subname: mangaItem.subname,
      imageThumb: image["thumb"],
      imageFull: image["full"],
      rate: getRate(meta),
      description: getDescription(content),
      isOngoing: getIsOngoing(meta),
      genres: getGenres(meta),
      year: getYear(meta),
      url: mangaItem.url,
      chapters: getChapters(content.parent, mangaItem.name)
    );
  }

  Map<String, String> getImage(Element content) {
    var result = <String, String>{};
    var items = content.getElementsByClassName("picture-fotorama");
    if (items.length == null) return result;
    // data-full
    // data-thumb маленькая картинка
    var img = items.first.children.first;
    result["thumb"] = img.attributes["data-thumb"];
    result["full"] = img.attributes["data-full"];
    return result;
  }

  bool getIsOngoing(Element meta) {
    var p = meta.getElementsByTagName("p");
    if (p.length < 2) return null;

    return p[1].text.contains("продолжается");
  }

  String getYear(Element meta) {
    var p = meta.getElementsByClassName("elem_year");
    if (p.length == 0) return null;

    return p.first.children.first.text;
  }

  String getDescription(Element content) {
    var p = content.getElementsByClassName("manga-description");
    if (p.length == 0) return "";

    return p.first.children.first.text;
  }

  List<String> getGenres(Element meta) {
    var span = meta.getElementsByClassName("elem_genre");
    return span.map((e) => e.children.first.text).toList();
  }

  String getRate(Element meta) {
    var span = meta.getElementsByClassName("rating-block");
    if (span.length == 0) return null;
    return span.first.attributes["score"];
  }

  List<Chapter> getChapters(Element content, String mangaName) {
    var result = <Chapter>[];
    var span = content.querySelector("div.chapters-link");
    if (span == null) return result;

    return span.getElementsByTagName("a").map((e) {
      String url = e.attributes["href"].checkHttps(ReadMangaStrategy.host);
      String name = e.text.replaceAll(RegExp(' +'), ' ').replaceAll("\n", " ").trim().replaceFirst(mangaName, "");
      return Chapter(name, url);
    }).toList();
  }
}
