import 'package:manga/core/presentation/BasePresenter.dart';
import 'package:manga/core/state/LoadingState.dart';
import 'package:manga/feature/manga_detail/data/model/MandaDetailParameter.dart';
import 'package:manga/feature/manga_detail/presentation/view/MangaDetailsState.dart';
import 'package:manga/feature/manga_detail/presentation/view/MangaDetailsView.dart';
import 'package:manga/feature/reader/data/model/ReaderParameter.dart';
import 'package:manga/feature/strategy/data/model/MangaDetails.dart';
import 'package:manga/route/route.dart';

class MangaDetailsPresenter extends BasePresenter<MangaDetailsView> {
  MangaDetailParameter _parameters;
  MangaDetailsState _state;

  MangaDetailsPresenter(this._parameters) {
    _state = MangaDetailsState(title: _parameters.item.name);
  }

  @override
  void initState() {
    view.bindState(LoadingState());
    loadData();
  }

  void loadData() async {
    await _parameters.strategy
        .getMangaDetail(_parameters.item)
        .then(handleMangaDetail)
        .catchError(handleDefaultError);
  }

  void handleMangaDetail(MangaDetail item) {
    view.bindState(_state.bind(
        imageThumb: item.imageThumb,
        description: item.description,
        currentChapterPosition: 0,
        chapters: item.chapters));
  }

  onClickChapterPrevious() {
    if (_state.currentChapterPosition == 0) return;
    _state.currentChapterPosition--;
    view.bindState(_state);
  }

  onClickChapterPlay() {
    MangaNavigator.openReaderScreen(
        ReaderParameter(_state.chapters, _state.currentChapterPosition, _parameters.strategy));
  }

  onClickChapterNext() {
    if (_state.chapters == null ||
        _state.chapters.length <= (_state.currentChapterPosition + 1)) return;
    _state.currentChapterPosition++;
    view.bindState(_state);
  }
}
