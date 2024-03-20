import 'package:chess_mobile_game/services/firestore/firestore_service.dart';
import 'package:chess_mobile_game/models/game.dart';

abstract class GameRepository {
  Future<void> createNewGame(Game game);
  Future<void> updateGameState(Game game);
  Stream<Game?> getGameStream(String gid);
}

class GameRepositoryImpl extends GameRepository {
  final FirestoreService _firestoreService;

  GameRepositoryImpl({
    required FirestoreService firestoreService,
  }) : _firestoreService = firestoreService;

  @override
  Future<void> createNewGame(Game game) => _firestoreService.createNewGame(game);

  @override
  Future<void> updateGameState(Game game) => _firestoreService.updateGameState(game);

  @override
  Stream<Game?> getGameStream(String gid) => _firestoreService.getGameStream(gid);
}
