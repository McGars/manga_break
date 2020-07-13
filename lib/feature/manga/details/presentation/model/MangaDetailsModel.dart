import 'package:flutter/widgets.dart';

class MangaDetailsModel with ChangeNotifier {

  bool _isFavorite = false;
  bool _isLoading = false;
  bool get isFavorite => _isFavorite;
  bool get isLoading => _isLoading;

  set setFavorite(bool value) {
    _isFavorite = value;
    _isLoading = false;
    notifyListeners();
  }

  set setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}