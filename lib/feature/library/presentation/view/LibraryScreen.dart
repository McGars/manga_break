import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:loadmore/loadmore.dart';
import 'package:manga/core/presentation/BaseWidgetState.dart';
import 'package:manga/core/state/EmptyState.dart';
import 'package:manga/core/state/ErrorState.dart';
import 'package:manga/core/state/LoadingState.dart';
import 'package:manga/di/ModuleContainer.dart';
import 'package:manga/feature/library/di/LibraryModule.dart';
import 'package:manga/feature/library/domain/model/LibraryData.dart';
import 'package:manga/feature/library/presentation/presenter/LibraryPresenter.dart';
import 'package:manga/feature/library/presentation/view/LibraryState.dart';
import 'package:manga/feature/library/presentation/view/LibraryView.dart';
import 'package:manga/feature/strategy/data/model/MangaItem.dart';

class LibraryScreen extends StatefulWidget {
  final injector = LibraryModule.inject(UniqueKey());

  LibraryScreen() {
    injectHolder.add(this, injector);
  }

  @override
  _LibraryScreenState createState() => _LibraryScreenState(injector);
}

class _LibraryScreenState extends BaseWidgetState<LibraryScreen, LibraryPresenter>
    implements LibraryView {
  var _searchQueryController = TextEditingController();
  var searchQuery = "Search query";

  _LibraryScreenState(Injector libraryInjector) : super(LibraryPresenter(libraryInjector));

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
          leading: state.isSearching || state.isFavorite ? BackButton(onPressed: presenter.onBackPressed,) : null,
          title: state.isSearching
              ? _buildSearchField()
              : Text(state.isFavorite
                  ? appLocalizations.libraryScreenTitleFavorite
                  : appLocalizations.libraryScreenTitle),
          actions: _buildActions(state),
        ),
        body: _buildList());
  }

  Widget _buildList() {
    return StreamBuilder<LibraryData>(
        stream: presenter.mangaListStream,
        builder: (context, snapshot) {

          if (snapshot?.hasError == true) {
            return getWidgetForState(ErrorState(snapshot.error.toString()));
          } else if (snapshot == null || !snapshot.hasData) {
            return getWidgetForState(LoadingState());
          }

          var items = snapshot.data.mangas;

          if (items.isEmpty) {
            return getWidgetForState(EmptyState(appLocalizations.empty));
          }

          // TODO переделать список в дата и добавить туда признак того что пагинация закончилась
          return AnimationLimiter(
            child: Scrollbar(
              child: LoadMore(
                isFinish: !snapshot.data.loadMore,
                whenEmptyLoad: false,
                textBuilder: (status) => !snapshot.data.loadMore ? "" : appLocalizations.loading,
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
                          child: _MangaItemWidget(items[index], presenter.onItemSelected),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        });
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
        hintStyle: const TextStyle(color: Colors.white30),
      ),
      style: const TextStyle(color: Colors.white, fontSize: 16.0),
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
    } else {
      var widgets = <Widget>[
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: presenter.onSearchButtonClicked,
        )
      ];

      if (!state.isFavorite) {
        widgets.add(IconButton(
          icon: const Icon(Icons.favorite),
          onPressed: presenter.onFavoriteButtonClicked,
        ));
        if (state.isUserAuthorize)
          widgets.add(
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: presenter.onExitButtonClicked,
            ),
          );
      }
      return widgets;
    }

  }

  @override
  void dispose() {
    super.dispose();
    injectHolder.dispose(widget);
  }
}

typedef void CallbackHandle<T>(T value);

class _MangaItemWidget extends StatelessWidget {
  final MangaItem _item;
  final CallbackHandle<MangaItem> _action;

  _MangaItemWidget(this._item, this._action);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: _item.image == null
          ? SizedBox(width: 64, height: 120)
          : Image.network(
              _item.image,
              width: 64,
              height: 120,
            ),
      title: Row(
        children: [
          Expanded(child: Container(child: Text('${_item.name}'))),
          Container(
              child: _item.isFavorite
                  ? Icon(Icons.favorite)
                  : SizedBox(
                      width: 24,
                      height: 24,
                    ))
        ],
      ),
      subtitle: _item.subname != null ? Text('${_item.subname}') : null,
      onTap: () => _action(_item),
    );
  }
}
