import 'dart:async';

import 'package:manga/feature/strategy/data/model/Chapter.dart';
import 'package:manga/feature/strategy/data/model/MangaDetails.dart';
import 'package:manga/feature/strategy/data/model/MangaItem.dart';
import 'package:manga/feature/strategy/data/model/MangaPage.dart';
import 'package:manga/feature/strategy/data/model/Pagination.dart';
import 'package:manga/feature/strategy/data/source/MangaStrategy.dart';
import 'package:html/parser.dart' show parse;
import 'package:manga/feature/strategy/data/source/readmanga/converter/ReadMangaDetailConverter.dart';
import 'package:manga/feature/strategy/data/source/readmanga/converter/ReadMangaListConverter.dart';
import 'package:http/http.dart' as http;
import 'package:manga/feature/strategy/data/source/readmanga/converter/ReadMangaPageConverter.dart';
import 'package:manga/main.dart';

class ReadMangaStrategy implements MangaStrategy {

  static const String host = "readmanga.me";
  static const String schema = "https";
  var pageOffset = 70;

  ReadMangaStrategy();

  @override
  Future<MangaDetail> getMangaDetail(MangaItem manga) async {
    var response = await http.get(manga.url);
    var document = parse(response.body);

    return ReadMangaDetailConverter().convert(manga, document);
  }

  @override
  Future<List<MangaItem>> getMangas(Pagination pagination) async {
    var url = _buildUrlForMangas(pagination);
    logger.d(url);
    var response = await http.get(url);
    var document = parse(response.body);

    return ReadMangaListConverter().convert(document);
  }

  @override
  Future<List<MangaPage>> getMangaPage(Chapter chapter) async {
    logger.d("getMangaPage");
    var response = await http.get(chapter.url);
    var document = parse(response.body);
    return ReadMangaPageConverter().convert(document);
  }

  Uri _buildUrlForMangas(Pagination pagination) {
    var genre = pagination.genre == null ? "" : "/genre/${pagination.genre}";
    var query = <String, String>{};

    if (pagination.sort != null) {
      query["sortType"] = pagination.sort;
    }
    query["offset"] = "${pagination.page * pageOffset}";
    query["max"] = "$pageOffset";

    return Uri.https(host, "/list$genre", query);
  }
}