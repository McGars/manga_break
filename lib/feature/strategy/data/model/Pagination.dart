class Pagination {
  int page;
  String sort;
  String genre;

  Pagination(this.page, this.sort, this.genre);

  @override
  String toString() {
    return 'Pagination{page: $page, sort: $sort, genre: $genre}';
  }
}