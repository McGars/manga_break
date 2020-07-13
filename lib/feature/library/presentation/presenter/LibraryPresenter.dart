import 'package:flutter_simple_dependency_injection/src/injector.dart';
import 'package:manga/core/presentation/BasePresenter.dart';
import 'package:manga/core/state/LoadingState.dart';
import 'package:manga/core/utils/Debouncer.dart';
import 'package:manga/feature/library/domain/model/LibraryData.dart';
import 'package:manga/feature/library/domain/use_case/LibrarySearchUseCase.dart';
import 'package:manga/feature/library/presentation/view/LibraryState.dart';
import 'package:manga/feature/library/presentation/view/LibraryView.dart';
import 'package:manga/feature/manga/details/data/model/MandaDetailParameter.dart';
import 'package:manga/feature/profile/personal/domain/model/MangaUser.dart';
import 'package:manga/feature/profile/personal/domain/use_case/MangaUserUseCase.dart';
import 'package:manga/feature/strategy/data/model/MangaItem.dart';
import 'package:manga/feature/strategy/data/source/favorite/FavoriteStrategy.dart';
import 'package:manga/feature/strategy/data/util/strategies_util.dart';
import 'package:manga/feature/strategy/domain/MangaContext.dart';
import 'package:manga/main.dart';
import 'package:manga/route/route.dart';

class LibraryPresenter extends BasePresenter<LibraryView> {
  var _mangaContext = MangaContext();
  var _viewState = LibraryState(items: []);
  var _currentPage = 0;
  LibrarySearchUseCase _librarySearchUseCase;
  var _debouncer = Debouncer();
  var _mangaUserUseCase = MyApp.injector.get<MangaUserUseCase>();

  Stream<LibraryData> get mangaListStream => _librarySearchUseCase.mangas;

  LibraryPresenter(Injector libraryInjector) {
    _librarySearchUseCase = libraryInjector.get<LibrarySearchUseCase>();
    _mangaContext.setStrategy(mangaStrategies[mangaStrategies.keys.first]);
  }

  @override
  void initState() async {
    view.bindState(LoadingState());
    await loadData();
    view.bindState(
        _viewState.bind(isUserAuthorize: _mangaUserUseCase.currentUser is AuthMangaUser));
  }

  Future<bool> loadData() async {
    var query = (_viewState.searchText == null || _viewState.searchText.isEmpty)
        ? _mangaContext.executeStrategyList(_currentPage++)
        : _mangaContext.search(_viewState.searchText, _currentPage++);

    await query
        .then((value) {
          _librarySearchUseCase.addMangas(value);
        })
        .catchError(_librarySearchUseCase.addErrors);

    return true;
  }

  void onItemSelected(MangaItem item) {
    var parameters = MangaDetailParameter(item, _mangaContext.currentStrategy.mangaStrategy);
    MangaNavigator.openDetailsScreen(parameters);
  }

  void search(String query) {
    _debouncer.run(() {
      _librarySearchUseCase.clearMangasForSearch();
      _currentPage = 0;
      _viewState.searchText = query;
      loadData();
    });
  }

  void onSearchButtonClicked() {
    view.bindState(_viewState.bind(isSearching: true));
  }

  void onClearSearchButtonClicked() {
    if (_viewState.searchText == null || _viewState.searchText.isEmpty) {
      _viewState.isSearching = false;
      view.bindState(_viewState);
    } else {
      _viewState.searchText = "";
      view.clearSearch();
      _reloadPage();
    }

  }

  void onFavoriteButtonClicked() async {
    var user = _mangaUserUseCase.currentUser;
    if (!user.isAuthorize) {
      await MangaNavigator.openAuthScreen().then((isSuccess) =>
          isSuccess == true ? view.bindState(_viewState.bind(isUserAuthorize: true)) : null);
    } else {
      _viewState.bind(isFavorite: true, isSearching: false);
      _mangaContext.setStrategy(mangaStrategies[FavoriteStrategy.host]);
      _clearPage();
      view.bindState(_viewState);
      loadData();
    }
  }

  @override
  void dispose() {
    _librarySearchUseCase.dispose();
    super.dispose();
  }

  void onExitButtonClicked() async {
    await _mangaUserUseCase.logout();
    view.bindState(_viewState.bind(isUserAuthorize: false));
  }

  void _clearPage() {
    _librarySearchUseCase.clearMangas();
    _currentPage = 0;
  }

  void onBackPressed() {
    if (_viewState.isFavorite) {
      _viewState.isFavorite = false;
      _mangaContext.setStrategy(mangaStrategies[mangaStrategies.keys.first]);
      _reloadPage();
    } else if (_viewState.isSearching) {
      onClearSearchButtonClicked();
    }
  }

  void _reloadPage() {
    _clearPage();
    view.bindState(_viewState);
    loadData();
  }

}
