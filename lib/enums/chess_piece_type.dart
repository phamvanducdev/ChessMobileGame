enum ChessPieceType { pawn, rook, knight, bishop, queen, king }

extension ChessPieceTypeEX on ChessPieceType {
  static ChessPieceType? fromString(String key) {
    switch (key.toLowerCase()) {
      case 'pawn':
        return ChessPieceType.pawn;
      case 'rook':
        return ChessPieceType.rook;
      case 'knight':
        return ChessPieceType.knight;
      case 'bishop':
        return ChessPieceType.bishop;
      case 'queen':
        return ChessPieceType.queen;
      case 'king':
        return ChessPieceType.king;
      default:
        return null;
    }
  }
}
