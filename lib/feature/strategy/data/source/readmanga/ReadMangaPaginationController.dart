import 'package:manga/feature/strategy/data/model/Filterparameter.dart';
import 'package:manga/feature/strategy/data/model/Pagination.dart';
import 'package:manga/feature/strategy/data/source/readmanga/ReadMangaParameters.dart';
import 'package:manga/feature/strategy/domain/PaginationController.dart';

class ReadMangaPaginationController implements PaginationController {

//  var sortingValues = { "popular": "Популярное","created": "Новое" , "updated": "Обновлённые", "votes": "По оценкам" };

  FilterParameter sort;
  FilterParameter genre;

  ReadMangaPaginationController({FilterParameter sort, this.genre}) {
    this.sort = sort ?? readMangaSort.first;
  }

  @override
  Pagination getPagination(int page) {
    return Pagination(page, sort.key, genre?.key);
  }
  
}