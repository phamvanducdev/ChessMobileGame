enum ChessPieceType { pawn, rook, knight, bishop, queen, king }

enum ChessPieceSide { white, black }

class ChessPiece {
  final ChessPieceType type;
  final ChessPieceSide side;
  final String assets;

  ChessPiece({
    required this.type,
    required this.side,
    required this.assets,
  });
}
