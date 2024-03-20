import 'package:chess_mobile_game/enums/chess_piece_side.dart';
import 'package:chess_mobile_game/enums/chess_piece_type.dart';

class ChessPiece {
  final ChessPieceType? type;
  final ChessPieceSide? side;

  ChessPiece({
    required this.type,
    required this.side,
  });

  factory ChessPiece.fromJson(Map<String, dynamic> json) {
    return ChessPiece(
      type: ChessPieceTypeEX.fromString(json['type']),
      side: ChessPieceSideEX.fromString(json['side']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type?.name,
      'side': side?.name,
    };
  }
}

extension ChessPieceEX on ChessPiece {
  String? get assets {
    switch (type) {
      case ChessPieceType.pawn:
        return side == ChessPieceSide.black ? 'assets/icons/ic_pawn_black.svg' : 'assets/icons/ic_pawn_white.svg';
      case ChessPieceType.rook:
        return side == ChessPieceSide.black ? 'assets/icons/ic_rook_black.svg' : 'assets/icons/ic_rook_white.svg';
      case ChessPieceType.knight:
        return side == ChessPieceSide.black ? 'assets/icons/ic_knight_black.svg' : 'assets/icons/ic_knight_white.svg';
      case ChessPieceType.bishop:
        return side == ChessPieceSide.black ? 'assets/icons/ic_bishop_black.svg' : 'assets/icons/ic_bishop_white.svg';
      case ChessPieceType.queen:
        return side == ChessPieceSide.black ? 'assets/icons/ic_queen_black.svg' : 'assets/icons/ic_queen_white.svg';
      case ChessPieceType.king:
        return side == ChessPieceSide.black ? 'assets/icons/ic_king_black.svg' : 'assets/icons/ic_king_white.svg';
      default:
        return null;
    }
  }
}
