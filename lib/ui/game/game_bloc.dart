import 'package:chess_mobile_game/enums/chess_piece_side.dart';
import 'package:chess_mobile_game/models/game.dart';
import 'package:rxdart/rxdart.dart';
import 'package:chess_mobile_game/models/chess_piece.dart';
import 'package:chess_mobile_game/repositories/auth_repository.dart';
import 'package:chess_mobile_game/repositories/game_repository.dart';
import 'package:chess_mobile_game/shared/base/base_bloc.dart';

class GameBLoC implements BaseBLoC {
  final AuthRepository _authRepository;
  final GameRepository _gameRepository;

  GameBLoC({
    required AuthRepository authRepository,
    required GameRepository gameRepository,
  })  : _authRepository = authRepository,
        _gameRepository = gameRepository;

  final _gameInfoObject = BehaviorSubject<Game>();
  Stream<Game> get gameInfoStream => _gameInfoObject.stream;

  final _pieceOnBoardListObject = BehaviorSubject<List<List<ChessPiece?>>>();
  Stream<List<List<ChessPiece?>>> get pieceOnBoardListStream => _pieceOnBoardListObject.stream;

  final _pieceTekenBlackListObject = BehaviorSubject<List<ChessPiece?>>();
  Stream<List<ChessPiece?>> get pieceTekenBlackListStream => _pieceTekenBlackListObject.stream;

  final _pieceTekenWhiteListObject = BehaviorSubject<List<ChessPiece?>>();
  Stream<List<ChessPiece?>> get pieceTekenWhiteListStream => _pieceTekenWhiteListObject.stream;

  Future<void> initializer(String gameId) async {
    _gameRepository.getGameStream(gameId).listen((gameInfo) {
      if (gameInfo == null) return;
      _gameInfoObject.add(gameInfo);
      _pieceOnBoardListObject.add(gameInfo.pieceOnBoardList);
      _pieceTekenBlackListObject.add(gameInfo.pieceTekenBlackList);
      _pieceTekenWhiteListObject.add(gameInfo.pieceTekenWhiteList);
    });
  }

  Future<void> updateGameChanged(
    ChessPieceSide currentTurn,
    List<List<ChessPiece?>> pieceOnBoardList,
    List<ChessPiece?> pieceTekenBlackList,
    List<ChessPiece?> pieceTekenWhiteList,
  ) async {
    final gameInfo = _gameInfoObject.value;
    _gameRepository.updateGameState(
      Game(
        gid: gameInfo.gid,
        hostId: gameInfo.hostId,
        guestId: gameInfo.guestId,
        currentTurn: currentTurn,
        pieceOnBoardList: pieceOnBoardList,
        pieceTekenBlackList: pieceTekenBlackList,
        pieceTekenWhiteList: pieceTekenWhiteList,
      ),
    );
  }

  @override
  void dispose() {
    // _gameInfoObject.close();
    // _pieceListObject.close();
    // _pieceWhiteTekenListObject.close();
    // _pieceBlackTekenListObject.close();
  }
}
