import 'package:html/dom.dart';
import 'dart:convert';
import 'package:manga/feature/strategy/data/model/MangaPage.dart';



class ReadMangaPageConverter {
  List<MangaPage> convert(Document document) {
    var script = document.body.innerHtml;

    RegExp exp = RegExp(r"rm_h.init\(.*(\[\[.+?\]\])", multiLine: true);
    RegExpMatch matches = exp.firstMatch(script);
    var json = matches.group(1).replaceAll("'", "\"");

    return (jsonDecode(json) as List).map((e) {
      var item = e as List;
      return MangaPage(item[0].toString() + item[2].toString());
    }).toList();
  }
}
