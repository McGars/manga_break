import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:manga/feature/manga/details/presentation/model/MangaDetailsModel.dart';
import 'package:provider/provider.dart';

class FavoriteToolbarWidget extends StatelessWidget {

  final void Function() clickListener;

  FavoriteToolbarWidget(this.clickListener);

  @override
  Widget build(BuildContext context) {
    return Consumer<MangaDetailsModel>(
      builder: (BuildContext context, value, Widget child) {
        if (value.isLoading) {
          return Center(
              child: Container(
                  margin: const EdgeInsets.only(left: 16, right: 16),
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2,)));
        } else {
          return IconButton(
              icon: value.isFavorite
                  ? const Icon(Icons.favorite)
                  : const Icon(Icons.favorite_border),
              onPressed: () {
                clickListener();
              });
        }
      },
    );
  }
}
