enum AppPage {
  HOME,
  AUTH,
  GAME,
  ERROR,
}

extension AppPageExt on AppPage {
  String get path {
    switch (this) {
      case AppPage.HOME:
        return '/';
      case AppPage.AUTH:
        return '/auth';
      case AppPage.GAME:
        return '/game/:gameId';
      case AppPage.ERROR:
        return '/error';
    }
  }

  String get pathRoute => path.replaceFirst('/', '');

  String pathParameters(String parameter) {
    switch (this) {
      case AppPage.HOME:
        throw UnimplementedError();
      case AppPage.AUTH:
        throw UnimplementedError();
      case AppPage.GAME:
        return '/game/$parameter';
      case AppPage.ERROR:
        throw UnimplementedError();
    }
  }
}
