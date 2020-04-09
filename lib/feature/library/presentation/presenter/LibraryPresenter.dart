import 'package:manga/core/presentation/BasePresenter.dart';
import 'package:manga/core/state/LoadingState.dart';
import 'package:manga/core/utils/Debouncer.dart';
import 'package:manga/feature/library/domain/use_case/LibrarySearchUseCase.dart';
import 'package:manga/feature/library/presentation/view/LibraryState.dart';
import 'package:manga/feature/library/presentation/view/LibraryView.dart';
import 'package:manga/feature/manga_detail/data/model/MandaDetailParameter.dart';
import 'package:manga/feature/strategy/data/model/MangaItem.dart';
import 'package:manga/feature/strategy/data/source/StrategyHolder.dart';
import 'package:manga/feature/strategy/data/source/readmanga/ReadMangaPaginationController.dart';
import 'package:manga/feature/strategy/data/source/readmanga/ReadMangaStrategy.dart';
import 'package:manga/feature/strategy/domain/MangaContext.dart';
import 'package:manga/main.dart';
import 'package:manga/route/route.dart';

class LibraryPresenter extends BasePresenter<LibraryView> {
  var _mangaContext = MangaContext();
  var _viewState = LibraryState(items: []);
  var _currentPage = 0;
  var _librarySearchUseCase = LibrarySearchUseCase();
  var _debauncer = Debouncer();

  Stream<List<MangaItem>> get mangaListStream => _librarySearchUseCase.mangas;

  var _mangaStrategies = <StrategyHolder>[
    StrategyHolder(MyApp.injector.get<ReadMangaStrategy>(),
        MyApp.injector.get<ReadMangaPaginationController>())
  ];

  LibraryPresenter() {
    _mangaContext.setStrategy(_mangaStrategies[0]);
  }

  @override
  void initState() async {
    view.bindState(LoadingState());
    await loadData();
    view.bindState(_viewState);
  }

  Future<bool> loadData() async {
    var query = (_viewState.searchText == null || _viewState.searchText.isEmpty)
        ? _mangaContext.executeStrategyList(_currentPage++)
        : _mangaContext.search(_viewState.searchText, _currentPage++);

    await query
        .then((value) => _librarySearchUseCase.addMangas(value))
        .catchError(_librarySearchUseCase.addErrors);

    return true;
  }

  void onItemSelected(MangaItem item) {
    var parameters =
        MangaDetailParameter(item, _mangaContext.currentStrategy.mangaStrategy);
    MangaNavigator.openDetailsScreen(parameters);
  }

  void search(String query) {
    _debauncer.run(() {
      logger.d("search: $query");
      _librarySearchUseCase.clearMangas();
      _currentPage = 0;
      _viewState.searchText = query;
      loadData();
    });
  }

  void setSearchState() {
    view.bindState(_viewState.clone(isSearching: true));
  }

  void onClearSearchButtonClicked() {
    if (_viewState.searchText == null || _viewState.searchText.isEmpty) {
      _viewState.isSearching = false;
    } else {
      _viewState.searchText = "";
      view.clearSearch();
    }

    view.bindState(_viewState);
  }

  @override
  void dispose() {
    _librarySearchUseCase.dispose();
    super.dispose();
  }
}
