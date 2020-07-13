import 'package:manga/feature/strategy/data/model/Pagination.dart';
import 'package:manga/feature/strategy/domain/PaginationController.dart';

class FavoritePaginationController implements PaginationController {

  @override
  Pagination getPagination(int page) {
    return Pagination(page, null, null);
  }

}