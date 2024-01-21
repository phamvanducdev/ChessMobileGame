import 'package:chess_mobile_game/domain/models/piece.dart';

class GameViewModel {
  // A 2-dimensional list representing the chessboard,
  // with each position possibly containing a chess piece.
  List<List<ChessPiece?>> boards = [];

  // The currently selected piece on the chess board,
  // If no piece is selected, this is null.
  ChessPiece? selectedPiece;

  // The row and colum index of the selected piece
  // Default value -1 indicated no piece is currently selected.
  int selectedRow = -1;
  int selectedColum = -1;

  // A list iff valid moves for currently selected piece
  // each move iss represented as a list with 2 elements: row and colum.
  List<List<int>> validMoves = [];

  // A list of white/black piece that have been taken by the black/white player.
  List<ChessPiece> whitePiecesTeken = [];
  List<ChessPiece> blackPiecesTeken = [];

  // To indicate whose turn it is
  ChessPieceSide currentTurn = ChessPieceSide.white;

  // Inital position of kings
  List<int> whiteKingPosition = [7, 4];
  List<int> blackKingPosition = [0, 4];
}
