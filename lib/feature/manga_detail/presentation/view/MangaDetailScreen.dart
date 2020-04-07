import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:manga/core/localization/AppLocalizations.dart';
import 'package:manga/core/presentation/BaseWidgetState.dart';
import 'package:manga/core/widget/ClickBehaviuor.dart';
import 'package:manga/di/ModuleContainer.dart';
import 'package:manga/feature/manga_detail/data/model/MandaDetailParameter.dart';
import 'package:manga/feature/manga_detail/presentation/presenter/MangaDetailsPresenter.dart';
import 'package:manga/feature/manga_detail/presentation/view/MangaDetailsState.dart';
import 'package:manga/feature/manga_detail/presentation/view/MangaDetailsView.dart';
import 'package:manga/main.dart';
import 'package:manga/route/route.dart';

class MangaDetailScreen extends StatefulWidget {
  final MangaDetailParameter _item;

  MangaDetailScreen(this._item);

  @override
  _MangaDetailScreenState createState() => _MangaDetailScreenState(_item);
}

class _MangaDetailScreenState
    extends BaseWidgetState<MangaDetailScreen, MangaDetailsPresenter>
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
    return state is MangaDetailsState
        ? _buildDetails(state)
        : _wrapWithAppBar(super.buildWidgetFromState());
  }

  String _getTitle() {
    var state = screenState;
    return state is MangaDetailsState ? state.title : "";
  }

  Widget _buildDetails(MangaDetailsState state) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: CustomScrollView(
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
      bottomNavigationBar: _bottomBar(state),
    );
  }

  Widget _appBarTitle(MangaDetailsState state) {
    var textStyle =
        Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.white);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(state.title, style: textStyle),
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

  //************* Bottom Bar */
  Widget _bottomBar(MangaDetailsState state) {
    return Container(
      color: Colors.white,
      height: 56,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _wrapBotomBarItem(_numberOfChapters(state)),
          _playButtons(state),
        ],
      ),
    );
  }

  Widget _numberOfChapters(MangaDetailsState state) {
    var titleStyle = Theme.of(context).textTheme.subtitle1;
    var subtitleStyle = Theme.of(context).textTheme.caption;
    var chaptersCount = state.chapters.length;

    List<Widget> body;
    if (chaptersCount == 0) {
      body = <Widget>[
        Text(appLocalizations.detailsScreenEmptyChapters, style: titleStyle)
      ];
    } else {
      body = <Widget>[
        Text(
          "${state.currentChapterPosition + 1} ${appLocalizations.ofTest} $chaptersCount",
          style: titleStyle,
        ),
        Text(
          appLocalizations.detailsScreenChaptersSubTitle,
          style: subtitleStyle,
        ),
      ];
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: body,
    );
  }

  Widget _playButtons(MangaDetailsState state) {
    if (state.chapters.isEmpty) {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Row(
        children: <Widget>[
          wrapCircleTransparentClick(
            Icon(Icons.skip_previous),
            () => presenter.onClickChapterPrevious(),
          ),
          wrapCircleTransparentClick(
            Icon(Icons.play_arrow),
            () => presenter.onClickChapterPlay(),
          ),
          wrapCircleTransparentClick(
            Icon(Icons.skip_next),
            () => presenter.onClickChapterNext(),
          )
        ],
      ),
    );
  }

  Widget _wrapBotomBarItem(Widget widget) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 8),
      height: 56,
      child: widget,
    );
  }

}
