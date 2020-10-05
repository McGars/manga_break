import 'package:flutter/material.dart';
import 'package:manga/feature/manga/details/presentation/view/MangaDetailsState.dart';
import 'package:manga/route/route.dart';

class ChapterListSheetWidget extends StatelessWidget {
  final MangaDetailsState state;

  final void Function(int) clickListener;

  const ChapterListSheetWidget(this.state, this.clickListener) : super();

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          height: 350.0,
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.only(top: 16),
            decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(16.0),
                    topRight: const Radius.circular(16.0))),
            child: ListView.builder(
              controller: scrollController,
              itemCount: state.chapters.length,
              itemBuilder: (BuildContext context, int index) {
                var item = state.chapters[index];
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {},
                    child: ListTile(
                      title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [Text(item.name)]),
                      onTap: () {
                        clickListener(index);
                        MangaNavigator.pop();
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
