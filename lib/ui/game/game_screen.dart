import 'package:chess_mobile_game/repositories/auth_repository.dart';
import 'package:chess_mobile_game/repositories/game_repository.dart';
import 'package:chess_mobile_game/ui/game/game_bloc.dart';
import 'package:chess_mobile_game/ui/game/widgets/game_board.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatelessWidget {
  final String gameId;

  const GameScreen({super.key, required this.gameId});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ProxyProvider2<AuthRepository, GameRepository, GameBLoC>(
          update: (context, authRepository, gameRepository, previous) =>
              previous ??
              GameBLoC(
                authRepository: authRepository,
                gameRepository: gameRepository,
              ),
          dispose: (_, bLoC) => bLoC.dispose(),
        ),
      ],
      child: GamePage(gameId: gameId),
    );
  }
}

class GamePage extends StatefulWidget {
  final String gameId;

  const GamePage({
    super.key,
    required this.gameId,
  });

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late GameBLoC _bLoC;

  @override
  void initState() {
    super.initState();
    _bLoC = context.read<GameBLoC>();
    _bLoC.initializer(widget.gameId);
  }

  @override
  Widget build(BuildContext context) {
    return const GameBoardWidget();
  }
}
