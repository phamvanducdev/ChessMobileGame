import 'package:chess_mobile_game/feature/game/widgets/game_board.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatelessWidget {
  final gid;
  const GameScreen({super.key, this.gid});

  @override
  Widget build(BuildContext context) {
    return const GameBoardWidget();
  }
}
