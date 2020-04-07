import 'package:manga/feature/strategy/data/model/Pagination.dart';

abstract class PaginationController {
   Pagination getPagination(int page);
}