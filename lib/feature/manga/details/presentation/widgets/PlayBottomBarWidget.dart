import 'package:flutter/material.dart';
import 'package:manga/core/widget/ClickBehaviuor.dart';
import 'package:manga/di/ModuleContainer.dart';
import 'package:manga/feature/manga/details/presentation/presenter/MangaDetailsPresenter.dart';
import 'package:manga/feature/manga/details/presentation/view/MangaDetailsState.dart';

class PlayBottomBarWidget extends StatelessWidget {

  final MangaDetailsState state;
  final MangaDetailsPresenter presenter;

  PlayBottomBarWidget(this.state, this.presenter);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 56,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(
                left: 16, top: 8, right: 16, bottom: 8),
            height: 56,
            child: _NumberOfChaptersWidget(state),
          ),
          _PlayButtonsWidget(state, presenter),
        ],
      ),);
  }

}

class _NumberOfChaptersWidget extends StatelessWidget {

  final MangaDetailsState state;

  _NumberOfChaptersWidget(this.state);

  @override
  Widget build(BuildContext context) {
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
}

class _PlayButtonsWidget extends StatelessWidget {

  final MangaDetailsState state;
  final MangaDetailsPresenter presenter;

  _PlayButtonsWidget(this.state, this.presenter);

  @override
  Widget build(BuildContext context) {
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
}
