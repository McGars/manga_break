import 'package:manga/core/state/BaseState.dart';
import 'package:manga/feature/strategy/data/model/MangaItem.dart';

class LibraryState implements BaseState {
  List<MangaItem> items;
  bool isSearching;
  bool isFavorite;
  String searchText;
  bool isUserAuthorize;

  LibraryState({this.items, this.isSearching = false, this.isFavorite = false, this.searchText, this.isUserAuthorize = false});

  LibraryState addMangas(List<MangaItem> items) {
    if (this.items == null) {
      this.items = items;
    } else {
      this.items.addAll(items);
    }
    return this;
  }

  LibraryState bind({
    List<MangaItem> items,
    bool isSearching,
    bool isFavorite,
    String searchText,
    bool isUserAuthorize,
  }) {
    this.items = items ?? this.items;
    this.isSearching = isSearching ?? this.isSearching;
    this.isFavorite = isFavorite ?? this.isFavorite;
    this.searchText =  searchText ?? this.searchText;
    this.isUserAuthorize = isUserAuthorize ?? this.isUserAuthorize;
    return this;
  }
}
