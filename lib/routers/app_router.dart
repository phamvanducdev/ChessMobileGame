import 'package:chess_mobile_game/ui/auth/login_screen.dart';
import 'package:chess_mobile_game/ui/game/game_screen.dart';
import 'package:chess_mobile_game/ui/home/home_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) => HomeScreen(),
      routes: <GoRoute>[
        GoRoute(
          path: 'auth',
          builder: (context, state) {
            return const LoginScreen();
          },
        ),
        GoRoute(
          path: 'game/:gameId',
          builder: (context, state) {
            final gameId = state.pathParameters['gameId'] ?? '';
            return GameScreen(gameId: gameId);
          },
        ),
      ],
    ),
  ],
);
