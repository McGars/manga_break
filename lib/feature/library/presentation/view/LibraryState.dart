import 'package:manga/core/state/BaseState.dart';
import 'package:manga/feature/strategy/data/model/MangaItem.dart';

class LibraryState implements BaseState {
  List<MangaItem> items;
  bool isSearching;
  String searchText;

  LibraryState({this.items, this.isSearching = false, this.searchText});

  LibraryState addMangas(List<MangaItem> items) {
    if (this.items == null) {
      this.items = items;
    } else {
      this.items.addAll(items);
    }
    return this;
  }

  LibraryState clone({
    List<MangaItem> items,
    bool isSearching,
    String searchText,
  }) {
    return LibraryState(
      items: items ?? this.items,
      isSearching: isSearching ?? this.isSearching,
      searchText: searchText ?? this.searchText,
    );
  }
}
