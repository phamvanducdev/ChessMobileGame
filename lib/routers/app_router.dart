import 'package:chess_mobile_game/feature/auth/signin_screen.dart';
import 'package:chess_mobile_game/feature/game/game_screen.dart';
import 'package:chess_mobile_game/feature/home/home_screen.dart';
import 'package:chess_mobile_game/feature/splash/splash_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      path: '/auth',
      builder: (context, state) {
        return const SignInScreen();
      },
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) {
        return const HomeScreen();
      },
      routes: [
        GoRoute(
          path: 'game',
          builder: (context, state) {
            return GameScreen(
              gid: state.extra as String?,
            );
          },
        ),
      ],
    ),
  ],
);
