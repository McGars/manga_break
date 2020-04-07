
import 'package:manga/feature/strategy/data/model/Chapter.dart';
import 'package:manga/feature/strategy/data/model/MangaDetails.dart';
import 'package:manga/feature/strategy/data/model/MangaItem.dart';
import 'package:manga/feature/strategy/data/model/MangaPage.dart';
import 'package:manga/feature/strategy/data/model/Pagination.dart';

abstract class MangaStrategy {

  Future<List<MangaItem>> getMangas(Pagination pagination);

  Future<MangaDetail> getMangaDetail(MangaItem manga);

  Future<List<MangaPage>> getMangaPage(Chapter chapter);

}