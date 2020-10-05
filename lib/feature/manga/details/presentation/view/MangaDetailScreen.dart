import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:manga/core/presentation/BaseWidgetState.dart';
import 'package:manga/core/state/LoadingState.dart';
import 'package:manga/feature/manga/details/data/model/MandaDetailParameter.dart';
import 'package:manga/feature/manga/details/presentation/model/MangaDetailsModel.dart';
import 'package:manga/feature/manga/details/presentation/presenter/MangaDetailsPresenter.dart';
import 'package:manga/feature/manga/details/presentation/view/MangaDetailsState.dart';
import 'package:manga/feature/manga/details/presentation/view/MangaDetailsView.dart';
import 'package:manga/feature/manga/details/presentation/widgets/ChapterListSheetWidget.dart';
import 'package:manga/feature/manga/details/presentation/widgets/FavoriteToolbarWidget.dart';
import 'package:manga/feature/manga/details/presentation/widgets/PlayBottomBarWidget.dart';
import 'package:provider/provider.dart';

class MangaDetailScreen extends StatefulWidget {
  final MangaDetailParameter _item;

  MangaDetailScreen(this._item);

  @override
  _MangaDetailScreenState createState() => _MangaDetailScreenState(_item);
}

class _MangaDetailScreenState
    extends BaseWidgetState<MangaDetailScreen, MangaDetailsPresenter>
    with TickerProviderStateMixin
    implements MangaDetailsView {
  _MangaDetailScreenState(MangaDetailParameter item)
      : super(MangaDetailsPresenter(item));

  @override
  Widget build(BuildContext context) {
    return buildWidgetFromState();
  }

  @override
  Widget buildWidgetFromState() {
    var state = screenState;

    if (state is LoadingState) {
      return Scaffold(body: super.buildWidgetFromState());
    } else if (state is MangaDetailsState) {
      return _buildDetails(state);
    } else {
      return _wrapWithAppBar(super.buildWidgetFromState());
    }
  }

  @override
  void showChapterList() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true, // set this to true
      builder: (_) =>
          ChapterListSheetWidget(screenState, presenter.onClickChapterSelected),
    );
  }

  String _getTitle() {
    var state = screenState;
    return state is MangaDetailsState ? state.title : "";
  }

  Widget _buildDetails(MangaDetailsState state) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: AnimationConfiguration.synchronized(
        child: FadeInAnimation(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverAppBar(
                stretch: true,
                onStretchTrigger: () {
                  // Function callback for stretch
                  return;
                },
                expandedHeight: 200.0,
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: <StretchMode>[
                    StretchMode.zoomBackground,
                    StretchMode.fadeTitle,
                  ],
                  centerTitle: true,
                  title: _appBarTitle(state),
                  background: _appBarBackground(state),
                ),
                actions: [
                  ChangeNotifierProvider<MangaDetailsModel>(
                    create: (context) => state.favoriteModel,
                    child: FavoriteToolbarWidget(
                        presenter.onFavoriteButtonClickedProvider),
                  ),
//              IconButton(
//                icon: state.isFavorite ? const Icon(Icons.favorite) : const Icon(Icons.favorite_border),
//                onPressed: presenter.onFavoriteButtonClicked,
//              )
                ],
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: 8),
                  ListTile(
                    title: Text(state.description),
                  ),
                  // ListTiles++
                ]),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: PlayBottomBarWidget(state, presenter),
//      bottomNavigationBar: _bottomBar(state),
    );
  }

  Widget _appBarTitle(MangaDetailsState state) {
    var textStyle =
        Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.white);
    return Container(
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.only(left: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.network(state.image, width: 50, height: 70),
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Text(state.title, style: textStyle),
              )),
        ],
      ),
    );
  }

  Widget _appBarBackground(MangaDetailsState state) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: Image.network(state.image).image,
            fit: BoxFit.cover,
            alignment: Alignment.topCenter),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(color: Colors.black.withOpacity(0.5)),
      ),
    );
  }

  Widget _wrapWithAppBar(Widget widget) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(_getTitle()),
      ),
      body: widget,
    );
  }
}
