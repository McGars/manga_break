import 'package:flutter/material.dart';
import 'package:manga/core/localization/AppLocalizations.dart';
import 'package:manga/core/presentation/BaseWidgetState.dart';
import 'package:manga/core/state/ErrorState.dart';
import 'package:manga/core/state/LoadingState.dart';
import 'package:manga/di/ModuleContainer.dart';
import 'package:manga/feature/library/presentation/presenter/LibraryPresenter.dart';
import 'package:manga/feature/library/presentation/view/LibraryState.dart';
import 'package:manga/feature/library/presentation/view/LibraryView.dart';
import 'package:manga/feature/strategy/data/model/MangaItem.dart';
import 'package:loadmore/loadmore.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class LibraryScreen extends StatefulWidget {
  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState
    extends BaseWidgetState<LibraryScreen, LibraryPresenter>
    implements LibraryView {
  var _searchQueryController = TextEditingController();
  var searchQuery = "Search query";

  _LibraryScreenState() : super(LibraryPresenter());

  @override
  Widget build(BuildContext context) {
    return buildWidgetFromState();
  }

  @override
  Widget buildWidgetFromState() {
    var state = screenState;
    return state is LibraryState
        ? _buildContent(state)
        : _defaultWrapWithAppBar(super.buildWidgetFromState());
  }

  @override
  void clearSearch() {
    _searchQueryController.clear();
  }

  Widget _buildContent(LibraryState state) {
    return Scaffold(
        appBar: AppBar(
          leading: state.isSearching ? const BackButton() : null,
          title: state.isSearching
              ? _buildSearchField()
              : Text(appLocalizations.libraryScreenTitle),
          actions: _buildActions(state),
        ),
        body: _buildList());
  }

  Widget _buildList() {
    return StreamBuilder<List<MangaItem>>(
      stream: presenter.mangaListStream,
      builder: (context, snapshot) {

        if (snapshot == null || !snapshot.hasData)
          return getWidgetForState(LoadingState());

        if (snapshot.hasError)
          // TODO
          return getWidgetForState(ErrorState(snapshot.error.toString()));

        var items = snapshot.data;

        return AnimationLimiter(
          child: Scrollbar(
            child: LoadMore(
              isFinish: false,
              onLoadMore: presenter.loadData,
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(
                        child: getMangaItem(items[index]),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      }
    );
  }

  Widget _getSubtitle(MangaItem item) {
    if (item.subname != null) return Text('${item.subname}');
    return null;
  }

  Widget getMangaItem(MangaItem item) {
    return ListTile(
      leading: Image.network(item.image),
      title: Text('${item.name}'),
      subtitle: _getSubtitle(item),
      onTap: () => presenter.onItemSelected(item),
    );
  }

  Widget _defaultWrapWithAppBar(Widget widget) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(appLocalizations.libraryScreenTitle),
      ),
      body: widget,
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchQueryController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: appLocalizations.libraryScreenSearchData,
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white30),
      ),
      style: TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: (query) => presenter.search(query),
    );
  }

  List<Widget> _buildActions(LibraryState state) {
    if (state.isSearching) {
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: presenter.onClearSearchButtonClicked,
        ),
      ];
    }

    return <Widget>[
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: () => presenter.setSearchState(),
      ),
    ];
  }

}
