import 'package:chess_mobile_game/enums/chess_piece_side.dart';
import 'package:chess_mobile_game/models/game.dart';
import 'package:chess_mobile_game/providers/user_provider.dart';
import 'package:chess_mobile_game/repositories/auth_repository.dart';
import 'package:chess_mobile_game/repositories/game_repository.dart';
import 'package:chess_mobile_game/shared/base/base_bloc.dart';
import 'package:chess_mobile_game/shared/helper/game_helper.dart';

class HomeBLoC implements BaseBLoC {
  final AuthRepository _authRepository;
  final GameRepository _gameRepository;

  HomeBLoC({
    required AuthRepository authRepository,
    required GameRepository gameRepository,
  })  : _authRepository = authRepository,
        _gameRepository = gameRepository;

  Future<void> onLogout() async {
    await _authRepository.signOut();
  }

  Future<void> createNewGame({String? guestId}) async {
    final hostId = UserProvider.userLogged?.uid;
    if (hostId == null) return;
    await _gameRepository.createNewGame(
      Game(
        gid: GameHelper.generateRoomCode(6),
        hostId: hostId,
        guestId: guestId,
        currentTurn: ChessPieceSide.white,
        pieceOnBoardList: GameHelper.generateBoards(),
        pieceTekenBlackList: [],
        pieceTekenWhiteList: [],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
