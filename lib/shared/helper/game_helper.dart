import 'dart:math';
import 'package:chess_mobile_game/enums/chess_piece_side.dart';
import 'package:chess_mobile_game/enums/chess_piece_type.dart';
import 'package:chess_mobile_game/models/chess_piece.dart';

class GameHelper {
  static String generateRoomCode(int length) {
    const String _validChars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    String roomCode = '';
    for (int i = 0; i < length; i++) {
      roomCode += _validChars[Random().nextInt(_validChars.length)];
    }
    return roomCode;
  }

  // initial boards 8x8
  static List<List<ChessPiece?>> generateBoards() {
    List<List<ChessPiece?>> boards = List.generate(8, (index) => List.generate(8, (index) => null));

    for (int i = 0; i < 8; i++) {
      // pawns black
      boards[1][i] = ChessPiece(
        type: ChessPieceType.pawn,
        side: ChessPieceSide.black,
      );
      // pawns white
      boards[6][i] = ChessPiece(
        type: ChessPieceType.pawn,
        side: ChessPieceSide.white,
      );
    }
    // rooks black
    boards[0][0] = ChessPiece(
      type: ChessPieceType.rook,
      side: ChessPieceSide.black,
    );
    boards[0][7] = ChessPiece(
      type: ChessPieceType.rook,
      side: ChessPieceSide.black,
    );
    // rooks white
    boards[7][0] = ChessPiece(
      type: ChessPieceType.rook,
      side: ChessPieceSide.white,
    );
    boards[7][7] = ChessPiece(
      type: ChessPieceType.rook,
      side: ChessPieceSide.white,
    );
    // knights black
    boards[0][1] = ChessPiece(
      type: ChessPieceType.knight,
      side: ChessPieceSide.black,
    );
    boards[0][6] = ChessPiece(
      type: ChessPieceType.knight,
      side: ChessPieceSide.black,
    );
    // knights white
    boards[7][1] = ChessPiece(
      type: ChessPieceType.knight,
      side: ChessPieceSide.white,
    );
    boards[7][6] = ChessPiece(
      type: ChessPieceType.knight,
      side: ChessPieceSide.white,
    );
    // bishops black
    boards[0][2] = ChessPiece(
      type: ChessPieceType.bishop,
      side: ChessPieceSide.black,
    );
    boards[0][5] = ChessPiece(
      type: ChessPieceType.bishop,
      side: ChessPieceSide.black,
    );
    // bishops white
    boards[7][2] = ChessPiece(
      type: ChessPieceType.bishop,
      side: ChessPieceSide.white,
    );
    boards[7][5] = ChessPiece(
      type: ChessPieceType.bishop,
      side: ChessPieceSide.white,
    );
    // queen black
    boards[0][3] = ChessPiece(
      type: ChessPieceType.queen,
      side: ChessPieceSide.black,
    );
    // queen white
    boards[7][3] = ChessPiece(
      type: ChessPieceType.queen,
      side: ChessPieceSide.white,
    );
    // king black
    boards[0][4] = ChessPiece(
      type: ChessPieceType.king,
      side: ChessPieceSide.black,
    );
    // king white
    boards[7][4] = ChessPiece(
      type: ChessPieceType.king,
      side: ChessPieceSide.white,
    );
    return boards;
  }

  static List<ChessPiece?> convertMatrixToList(List<List<ChessPiece?>> matrix) {
    List<ChessPiece?> pieceList = [];
    for (var row = 0; row < matrix.length; row++) {
      for (var colum = 0; colum < matrix[row].length; colum++) {
        pieceList.add(matrix[row][colum]);
      }
    }
    return pieceList;
  }

  static List<List<ChessPiece?>> convertListToMatrix(List<ChessPiece?> pieceList) {
    final List<List<ChessPiece?>> matrix = List.generate(8, (index) => List.generate(8, (index) => null));
    for (int i = 0; i < pieceList.length; i++) {
      matrix[i ~/ 8][i % 8] = pieceList[i];
    }
    return matrix;
  }

  static bool isInBoard(int row, int colum) {
    return row >= 0 && row <= 7 && colum >= 0 && colum <= 7;
  }

  static List<int> pieceBlackKingPosition(List<List<ChessPiece?>> pieceList) {
    List<int> kingPosition = [];
    for (var row = 0; row < pieceList.length; row++) {
      for (var colum = 0; colum < pieceList[row].length; colum++) {
        if (pieceList[row][colum] != null &&
            pieceList[row][colum]?.type == ChessPieceType.king &&
            pieceList[row][colum]?.side == ChessPieceSide.black) {
          kingPosition.add(row);
          kingPosition.add(colum);
        }
      }
    }
    return kingPosition;
  }

  static List<int> pieceWhiteKingPosition(List<List<ChessPiece?>> pieceList) {
    List<int> kingPosition = [];
    for (var row = 0; row < pieceList.length; row++) {
      for (var colum = 0; colum < pieceList[row].length; colum++) {
        if (pieceList[row][colum] != null &&
            pieceList[row][colum]?.type == ChessPieceType.king &&
            pieceList[row][colum]?.side == ChessPieceSide.white) {
          kingPosition.add(row);
          kingPosition.add(colum);
        }
      }
    }
    return kingPosition;
  }

  static List<List<int>> validMovePositions(
    List<List<ChessPiece?>> pieceOnBoardMatrix,
    ChessPiece? pieceSelected,
    int rowPieceSelected,
    int columPieceSelected,
  ) {
    List<List<int>> validMovePositions = [];

    switch (pieceSelected?.type) {
      case ChessPieceType.pawn:
        int direction = pieceSelected?.side == ChessPieceSide.black ? 1 : -1;

        // pawns can move forward if square is not occupied
        if (isInBoard(rowPieceSelected + direction, columPieceSelected) &&
            pieceOnBoardMatrix[rowPieceSelected + direction][columPieceSelected] == null) {
          validMovePositions.add([rowPieceSelected + direction, columPieceSelected]);
        }
        // pawns can move 2 squares forward if they are at their inital position
        if (rowPieceSelected == 1 && pieceSelected?.side == ChessPieceSide.black ||
            rowPieceSelected == 6 && pieceSelected?.side == ChessPieceSide.white) {
          if (pieceOnBoardMatrix[rowPieceSelected + direction][columPieceSelected] == null &&
              pieceOnBoardMatrix[rowPieceSelected + 2 * direction][columPieceSelected] == null) {
            validMovePositions.add([rowPieceSelected + 2 * direction, columPieceSelected]);
          }
        }
        // pawn can kill diagonally
        if (isInBoard(rowPieceSelected + direction, columPieceSelected - 1) &&
            pieceOnBoardMatrix[rowPieceSelected + direction][columPieceSelected - 1] != null &&
            pieceOnBoardMatrix[rowPieceSelected + direction][columPieceSelected - 1]?.side != pieceSelected?.side) {
          validMovePositions.add([rowPieceSelected + direction, columPieceSelected - 1]);
        }
        if (isInBoard(rowPieceSelected + direction, columPieceSelected + 1) &&
            pieceOnBoardMatrix[rowPieceSelected + direction][columPieceSelected + 1] != null &&
            pieceOnBoardMatrix[rowPieceSelected + direction][columPieceSelected + 1]?.side != pieceSelected?.side) {
          validMovePositions.add([rowPieceSelected + direction, columPieceSelected + 1]);
        }
        break;
      case ChessPieceType.rook:
        List<List<int>> directions = [
          [-1, 0], // 1↑
          [1, 0], // 1↓
          [0, -1], // 1←
          [0, 1], // 1→
        ];
        for (List<int> direction in directions) {
          int i = 1;
          while (true) {
            int nextRow = rowPieceSelected + i * direction[0];
            int nextColum = columPieceSelected + i * direction[1];
            if (!isInBoard(nextRow, nextColum)) {
              break; // out boards
            }
            if (pieceOnBoardMatrix[nextRow][nextColum] != null) {
              if (pieceOnBoardMatrix[nextRow][nextColum]?.side != pieceSelected?.side) {
                validMovePositions.add([nextRow, nextColum]);
              }
              break; // blocked
            }
            validMovePositions.add([nextRow, nextColum]);
            i++;
          }
        }
        break;
      case ChessPieceType.knight:
        List<List<int>> knightMoves = [
          [-2, -1], // 2↑ 1←
          [-2, 1], // 2↑ 1→
          [-1, -2], // 1↑ 2←
          [-1, 2], // 1↑ 2→
          [1, -2], // 1↓ 2←
          [1, 2], // 1↓ 2→
          [2, -1], // 2↓ 1←
          [2, 1], // 2↓ 1→
        ];
        for (List<int> move in knightMoves) {
          int nextRow = rowPieceSelected + move[0];
          int nextColum = columPieceSelected + move[1];
          if (!isInBoard(nextRow, nextColum)) {
            continue; // out boards
          }
          if (pieceOnBoardMatrix[nextRow][nextColum] != null) {
            if (pieceOnBoardMatrix[nextRow][nextColum]?.side != pieceSelected?.side) {
              validMovePositions.add([nextRow, nextColum]);
            }
            continue; // blocked
          }
          validMovePositions.add([nextRow, nextColum]);
        }
        break;
      case ChessPieceType.bishop:
        List<List<int>> directions = [
          [-1, -1], // 1↑ 1←
          [-1, 1], // 1↑ 1→
          [1, -1], // 1↓ 1←
          [1, 1], // 1↓ 1→
        ];
        for (List<int> direction in directions) {
          int i = 1;
          while (true) {
            int nextRow = rowPieceSelected + i * direction[0];
            int nextColum = columPieceSelected + i * direction[1];
            if (!isInBoard(nextRow, nextColum)) {
              break; // out boards
            }
            if (pieceOnBoardMatrix[nextRow][nextColum] != null) {
              if (pieceOnBoardMatrix[nextRow][nextColum]?.side != pieceSelected?.side) {
                validMovePositions.add([nextRow, nextColum]);
              }
              break; // blocked
            }
            validMovePositions.add([nextRow, nextColum]);
            i++;
          }
        }
        break;
      case ChessPieceType.queen:
        List<List<int>> directions = [
          [-1, 0], // 1↑
          [1, 0], // 1↓
          [0, -1], // 1←
          [0, 1], // 1→
          [-1, -1], // 1↑ 1←
          [-1, 1], //  1↑ 1→
          [1, -1], // 1↓ 1←
          [1, 1], // 1↓ 1→
        ];
        for (List<int> direction in directions) {
          int i = 1;
          while (true) {
            int nextRow = rowPieceSelected + i * direction[0];
            int nextColum = columPieceSelected + i * direction[1];
            if (!isInBoard(nextRow, nextColum)) {
              break; // out boards
            }
            if (pieceOnBoardMatrix[nextRow][nextColum] != null) {
              if (pieceOnBoardMatrix[nextRow][nextColum]?.side != pieceSelected?.side) {
                validMovePositions.add([nextRow, nextColum]);
              }
              break; // blocked
            }
            validMovePositions.add([nextRow, nextColum]);
            i++;
          }
        }
        break;
      case ChessPieceType.king:
        List<List<int>> directions = [
          [-1, 0], // 1↑
          [1, 0], // 1↓
          [0, -1], // 1←
          [0, 1], // 1→
          [-1, -1], // 1↑ 1←
          [-1, 1], // 1↑ 1→
          [1, -1], // 1↓ 1←
          [1, 1], // 1↓ 1→
        ];
        for (List<int> direction in directions) {
          int i = 1;
          while (true) {
            int nextRow = rowPieceSelected + i * direction[0];
            int nextColum = columPieceSelected + i * direction[1];
            if (!isInBoard(nextRow, nextColum)) {
              break; // out boards
            }
            if (pieceOnBoardMatrix[nextRow][nextColum] != null) {
              if (pieceOnBoardMatrix[nextRow][nextColum]?.side != pieceSelected?.side) {
                validMovePositions.add([nextRow, nextColum]);
              }
              break; // blocked
            }
            validMovePositions.add([nextRow, nextColum]);
            i++;
          }
        }
        break;
      default:
        break;
    }
    return validMovePositions;
  }
}
