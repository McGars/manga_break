import 'dart:ui' as ui;

import 'package:firebase/firebase_io.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:manga/core/data/ConnectionStatus.dart';
import 'package:manga/core/data/MangaHttp.dart';
import 'package:manga/core/use_case/EncriptUseCase.dart';
import 'package:manga/core/utils/AppLocalizations.dart';
import 'package:manga/di/InjectHolder.dart';
import 'package:manga/feature/firebase/data/repository/FirebaseAuthRepository.dart';
import 'package:manga/feature/firebase/data/repository/FirebaseDatabaseRepository.dart';
import 'package:manga/feature/firebase/use_case/FirebaseDatabaseUseCase.dart';
import 'package:manga/feature/firebase/use_case/MangaFirebaseClient.dart';
import 'package:manga/feature/profile/personal/domain/use_case/MangaUserUseCase.dart';
import 'package:manga/feature/strategy/data/source/favorite/FavoritePaginationController.dart';
import 'package:manga/feature/strategy/data/source/favorite/FavoriteStrategy.dart';
import 'package:manga/feature/strategy/data/source/readmanga/ReadMangaPaginationController.dart';
import 'package:manga/feature/strategy/data/source/readmanga/ReadMangaStrategy.dart';
import 'package:manga/main.dart';

//    injector.map<String>((i) => "https://api.com/", key: "apiUrl");
//    injector.map<SomeService>(
//            (i) => SomeService(i.get<Logger>(), i.get<String>(key: "apiUrl")));
//
//    injector.map<SomeType>((injector) => SomeType("0"));
//    injector.map<SomeType>((injector) => SomeType("1"), key: "One");
//    injector.map<SomeType>((injector) => SomeType("2"), key: "Two");
//
//    injector.mapWithParams<SomeOtherType>((i, p) => SomeOtherType(p["id"]));

class ModuleContainer {
  Injector initialise(Injector injector) {
    /// Core
    injector.map<MangaHttpOverrides>((i) => MangaHttpOverrides(), isSingleton: true);
    injector.map<ConnectionStatus>((i) => ConnectionStatus.getInstance(), isSingleton: true);
    injector.map<EncriptUseCase>((i) => EncriptUseCase(), isSingleton: true);
    injector.map<InjectHolder>((i) => InjectHolder(), isSingleton: true);

    /// firebase
    injector.map<FirebaseClient>((i) => FirebaseClient(null), isSingleton: true);
    injector.map<MangaFirebseClient>((i) => MangaFirebseClient(i.get<MangaUserUseCase>()),
        isSingleton: true);
    injector.map<FireBaseRepository>((i) => FireBaseRepository(i.get<FirebaseClient>()),
        isSingleton: true);
    injector.map<FirebaseDatabaseRepository>(
        (i) => FirebaseDatabaseRepository(i.get<MangaFirebseClient>()),
        isSingleton: true);
    injector.map<FirebaseDatabaseUseCase>(
        (i) =>
            FirebaseDatabaseUseCase(i.get<MangaUserUseCase>(), i.get<FirebaseDatabaseRepository>()),
        isSingleton: true);
//    injector.map<fb.Auth>((i) => fb.auth(), isSingleton: true);
//    injector.map<fb.Database>((i) => fb.database(), isSingleton: true);

    /// Profile
    injector.map<MangaUserUseCase>(
        (i) => MangaUserUseCase(
              i.get<FireBaseRepository>(),
              i.get<AppLocalizations>(),
              i.get<EncriptUseCase>(),
            ),
        isSingleton: true);
//    injector.map<MangaUser>((i) => i.get<MangaUserUseCase>().mangaUser, isSingleton: false);

    /// Strategy
    // readmanga
    injector.map<ReadMangaStrategy>((i) => ReadMangaStrategy(), isSingleton: true);
    injector.map<ReadMangaPaginationController>((i) => ReadMangaPaginationController(),
        isSingleton: true);
    // favorite
    injector.map<FavoriteStrategy>((i) => FavoriteStrategy(i.get<FirebaseDatabaseUseCase>()),
        isSingleton: true);
    injector.map<FavoritePaginationController>((i) => FavoritePaginationController(),
        isSingleton: true);

    /// localization
    injector.map<AppLocalizations>((i) => AppLocalizations(ui.window.locale), isSingleton: true);

    return injector;
  }
}

// quick access
AppLocalizations get appLocalizations => MyApp.injector.get<AppLocalizations>();

bool get connectionAvailable => MyApp.injector.get<ConnectionStatus>().hasConnection;

InjectHolder get injectHolder => MyApp.injector.get<InjectHolder>();