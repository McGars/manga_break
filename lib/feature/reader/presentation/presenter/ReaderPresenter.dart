import 'package:manga/core/presentation/BasePresenter.dart';
import 'package:manga/feature/reader/data/model/ReaderParameter.dart';
import 'package:manga/feature/reader/presentation/view/ReaderState.dart';
import 'package:manga/feature/reader/presentation/view/ReaderView.dart';

class ReaderPresenter extends BasePresenter<ReaderView> {
  ReaderParameter _parameter;
  ReaderState _state = ReaderState();

  ReaderPresenter(this._parameter);

  @override
  void initState() async {
    var chapter = _parameter.chapters[_parameter.currentPosition];
    var pages = await _parameter.strategy.getMangaPage(chapter);

    // todo last see page
    view.bindState(_state.bind(
      pages: pages,
      initialPosition: 0,
    ));
  }
}
