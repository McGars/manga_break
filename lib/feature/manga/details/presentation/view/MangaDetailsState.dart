import 'package:manga/core/state/BaseState.dart';
import 'package:manga/feature/strategy/data/model/Chapter.dart';

class MangaDetailsState implements BaseState {
  String title;
  String image;

  /* Nullable */
  String description;
  Chapter currentChapter;
  int currentChapterPosition = 0;
  List<Chapter> chapters;

  MangaDetailsState({this.title, this.image, this.description});

  MangaDetailsState bind({
    title,
    String imageThumb,
    String description,
    List<Chapter> chapters,
    int currentChapterPosition,
  }) {
    this.title = title ?? this.title;
    this.image = imageThumb ?? this.image;
    this.description = description ?? this.description;
    this.currentChapterPosition =
        currentChapterPosition ?? this.currentChapterPosition;
    this.chapters = chapters ?? this.chapters;
    return this;
  }
}
