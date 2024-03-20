import 'package:chess_mobile_game/enums/chess_piece_side.dart';
import 'package:chess_mobile_game/models/chess_piece.dart';
import 'package:chess_mobile_game/shared/helper/game_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Game {
  final String gid;
  final String hostId;
  final String? guestId;
  final ChessPieceSide currentTurn;
  final List<List<ChessPiece?>> pieceOnBoardList;
  final List<ChessPiece?> pieceTekenBlackList;
  final List<ChessPiece?> pieceTekenWhiteList;

  Game({
    required this.gid,
    required this.hostId,
    required this.guestId,
    required this.currentTurn,
    required this.pieceOnBoardList,
    required this.pieceTekenBlackList,
    required this.pieceTekenWhiteList,
  });

  factory Game.fromSnapshot(DocumentSnapshot snapshot) {
    final snapshotData = snapshot.data() as Map<String, dynamic>;
    final pieceOnBoardList = (snapshotData['pieceOnBoardList'] as List<dynamic>?)
        ?.map(
          (json) => json != null ? ChessPiece.fromJson(json as Map<String, dynamic>) : null,
        )
        .toList();
    final pieceTekenBlackList = (snapshotData['pieceTekenBlackList'] as List<dynamic>?)
        ?.map(
          (json) => json != null ? ChessPiece.fromJson(json as Map<String, dynamic>) : null,
        )
        .toList();
    final pieceTekenWhiteList = (snapshotData['pieceTekenWhiteList'] as List<dynamic>?)
        ?.map(
          (json) => json != null ? ChessPiece.fromJson(json as Map<String, dynamic>) : null,
        )
        .toList();
    return Game(
      gid: snapshot.id,
      hostId: snapshotData['hostId'],
      guestId: snapshotData['guestId'],
      currentTurn: ChessPieceSideEX.fromString(snapshotData['currentTurn']) ?? ChessPieceSide.white,
      pieceOnBoardList: GameHelper.convertListToMatrix(pieceOnBoardList ?? []),
      pieceTekenBlackList: pieceTekenBlackList ?? [],
      pieceTekenWhiteList: pieceTekenWhiteList ?? [],
    );
  }

  Map<String, dynamic> toJsonDocument() {
    return {
      'hostId': hostId,
      'guestId': guestId,
      'currentTurn': currentTurn.name,
      'pieceOnBoardList': GameHelper.convertMatrixToList(pieceOnBoardList).map((piece) => piece?.toJson()).toList(),
      'pieceTekenBlackList': pieceTekenBlackList.map((piece) => piece?.toJson()).toList(),
      'pieceTekenWhiteList': pieceTekenWhiteList.map((piece) => piece?.toJson()).toList(),
    };
  }
}
