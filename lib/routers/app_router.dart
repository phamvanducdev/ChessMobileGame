import 'package:chess_mobile_game/providers/user_provider.dart';
import 'package:chess_mobile_game/routers/app_page.dart';
import 'package:chess_mobile_game/routers/error_page.dart';
import 'package:chess_mobile_game/ui/auth/login_screen.dart';
import 'package:chess_mobile_game/ui/game/game_screen.dart';
import 'package:chess_mobile_game/ui/home/home_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppPage.HOME.path,
  routes: <RouteBase>[
    GoRoute(
      path: AppPage.HOME.path,
      builder: (context, state) => HomeScreen(),
      routes: [
        GoRoute(
          path: AppPage.AUTH.pathRoute,
          builder: (context, state) {
            return const LoginScreen();
          },
        ),
        GoRoute(
          path: AppPage.GAME.pathRoute,
          builder: (context, state) {
            final gameId = state.pathParameters['gameId'];
            if (gameId == null) {
              return ErrorPage(errorMessage: 'Not found game!');
            }
            return GameScreen(gameId: gameId);
          },
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) {
    print(state.error);
    return ErrorPage(errorMessage: state.error.toString());
  },
  redirect: (context, state) async {
    if (state.fullPath == AppPage.GAME.path) {
      if (UserProvider.userLogged == null) {
        return AppPage.AUTH.path;
      }
    }
    return null;
  },
);
