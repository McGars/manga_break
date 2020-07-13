import 'package:manga/core/presentation/BasePresenter.dart';
import 'package:manga/core/state/LoadingState.dart';
import 'package:manga/di/ModuleContainer.dart';
import 'package:manga/feature/firebase/use_case/FirebaseDatabaseUseCase.dart';
import 'package:manga/feature/library/domain/use_case/LibrarySearchUseCase.dart';
import 'package:manga/feature/library/presentation/view/LibraryScreen.dart';
import 'package:manga/feature/manga/details/data/model/MandaDetailParameter.dart';
import 'package:manga/feature/manga/details/presentation/view/MangaDetailsState.dart';
import 'package:manga/feature/manga/details/presentation/view/MangaDetailsView.dart';
import 'package:manga/feature/manga/reader/data/model/ReaderParameter.dart';
import 'package:manga/feature/strategy/data/model/MangaDetails.dart';
import 'package:manga/main.dart';
import 'package:manga/route/route.dart';

class MangaDetailsPresenter extends BasePresenter<MangaDetailsView> {
  MangaDetailParameter _parameters;
  MangaDetailsState _state;

  var _firebaseDatabaseUseCase = MyApp.injector.get<FirebaseDatabaseUseCase>();

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
    view.bindState(
      _state.bind(
          imageThumb: item.imageThumb,
          description: item.description,
          currentChapterPosition: 0,
          chapters: item.chapters,
          isFavorite: _firebaseDatabaseUseCase.isInFavorite(item.url)),
    );
  }

  onClickChapterPrevious() {
    if (_state.currentChapterPosition == 0) return;
    _state.currentChapterPosition--;
    view.bindState(_state);
  }

  onClickChapterPlay() {
    MangaNavigator.openReaderScreen(ReaderParameter(
        _state.chapters, _state.currentChapterPosition, _parameters.strategy));
  }

  onClickChapterNext() {
    if (_state.chapters == null ||
        _state.chapters.length <= (_state.currentChapterPosition + 1)) return;
    _state.currentChapterPosition++;
    view.bindState(_state);
  }

  /// Change favorite status for manga
  void onFavoriteButtonClickedProvider() async {
    if (!connectionAvailable) {
      view.showErrorDialog(appLocalizations.errorConnection);
      return;
    }

    _state.favoriteModel.setLoading = true;

    _state.favoriteModel.isFavorite
        ? await _firebaseDatabaseUseCase.removeFromFavorite(_parameters.item)
        : await _firebaseDatabaseUseCase.addToFavorite(_parameters.item);

    _state.favoriteModel.setFavorite = !_state.favoriteModel.isFavorite;

    // update favorite in list
    injectHolder.get<LibraryScreen>().forEach((injector) {
      injector.get<LibrarySearchUseCase>().setFavorite(_parameters.item.url, _state.favoriteModel.isFavorite);
    });

  }

}
