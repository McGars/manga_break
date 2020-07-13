import 'package:manga/core/presentation/BasePresenter.dart';
import 'package:manga/core/state/LoadingState.dart';
import 'package:manga/feature/firebase/use_case/FirebaseDatabaseUseCase.dart';
import 'package:manga/feature/loading/presentation/view/LoadingView.dart';
import 'package:manga/feature/profile/personal/domain/use_case/MangaUserUseCase.dart';
import 'package:manga/main.dart';
import 'package:manga/route/route.dart';

class LoadingPresenter extends BasePresenter<LoadingView> {

  @override
  void initState() async {
    view.bindState(LoadingState());
    // init data
    await _initUser();
    await Future.delayed(Duration(milliseconds: 300));
    MangaNavigator.openHome();
  }

  Future<void> _initUser() async {
    var userUseCase = MyApp.injector.get<MangaUserUseCase>();
    var firebaseDatabase = MyApp.injector.get<FirebaseDatabaseUseCase>();
    // TODO FirebaseClientException, 401
    await userUseCase.loadUserData();
    await firebaseDatabase.syncData();
  }
  
}
