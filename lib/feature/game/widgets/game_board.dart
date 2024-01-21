import 'package:chess_mobile_game/feature/game/widgets/square.dart';
import 'package:chess_mobile_game/domain/models/piece.dart';
import 'package:chess_mobile_game/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GameBoardWidget extends StatefulWidget {
  const GameBoardWidget({super.key});

  @override
  State<GameBoardWidget> createState() => _GameBoardWidgetState();
}

class _GameBoardWidgetState extends State<GameBoardWidget> {
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

  @override
  void initState() {
    super.initState();
    _initializedGameBoards();
  }

  void _initializedGameBoards() {
    // Intial game board 8*8
    boards = List.generate(8, (index) => List.generate(8, (index) => null));

    for (int i = 0; i < 8; i++) {
      // Pawns black
      boards[1][i] = ChessPiece(
        type: ChessPieceType.pawn,
        side: ChessPieceSide.black,
        assets: 'assets/icons/ic_pawn_black.svg',
      );
      // Pawns white
      boards[6][i] = ChessPiece(
        type: ChessPieceType.pawn,
        side: ChessPieceSide.white,
        assets: 'assets/icons/ic_pawn_white.svg',
      );
    }
    // Rooks black
    boards[0][0] = ChessPiece(
      type: ChessPieceType.rook,
      side: ChessPieceSide.black,
      assets: 'assets/icons/ic_rook_black.svg',
    );
    boards[0][7] = ChessPiece(
      type: ChessPieceType.rook,
      side: ChessPieceSide.black,
      assets: 'assets/icons/ic_rook_black.svg',
    );
    // Rooks white
    boards[7][0] = ChessPiece(
      type: ChessPieceType.rook,
      side: ChessPieceSide.white,
      assets: 'assets/icons/ic_rook_white.svg',
    );
    boards[7][7] = ChessPiece(
      type: ChessPieceType.rook,
      side: ChessPieceSide.white,
      assets: 'assets/icons/ic_rook_white.svg',
    );
    // Knights black
    boards[0][1] = ChessPiece(
      type: ChessPieceType.knight,
      side: ChessPieceSide.black,
      assets: 'assets/icons/ic_knight_black.svg',
    );
    boards[0][6] = ChessPiece(
      type: ChessPieceType.knight,
      side: ChessPieceSide.black,
      assets: 'assets/icons/ic_knight_black.svg',
    );
    // Knights white
    boards[7][1] = ChessPiece(
      type: ChessPieceType.knight,
      side: ChessPieceSide.white,
      assets: 'assets/icons/ic_knight_white.svg',
    );
    boards[7][6] = ChessPiece(
      type: ChessPieceType.knight,
      side: ChessPieceSide.white,
      assets: 'assets/icons/ic_knight_white.svg',
    );
    // Bishops black
    boards[0][2] = ChessPiece(
      type: ChessPieceType.bishop,
      side: ChessPieceSide.black,
      assets: 'assets/icons/ic_bishop_black.svg',
    );
    boards[0][5] = ChessPiece(
      type: ChessPieceType.bishop,
      side: ChessPieceSide.black,
      assets: 'assets/icons/ic_bishop_black.svg',
    );
    // Bishops white
    boards[7][2] = ChessPiece(
      type: ChessPieceType.bishop,
      side: ChessPieceSide.white,
      assets: 'assets/icons/ic_bishop_white.svg',
    );
    boards[7][5] = ChessPiece(
      type: ChessPieceType.bishop,
      side: ChessPieceSide.white,
      assets: 'assets/icons/ic_bishop_white.svg',
    );
    // Queen black
    boards[0][3] = ChessPiece(
      type: ChessPieceType.queen,
      side: ChessPieceSide.black,
      assets: 'assets/icons/ic_queen_black.svg',
    );
    // Queen white
    boards[7][3] = ChessPiece(
      type: ChessPieceType.queen,
      side: ChessPieceSide.white,
      assets: 'assets/icons/ic_queen_white.svg',
    );
    // King black
    boards[0][4] = ChessPiece(
      type: ChessPieceType.king,
      side: ChessPieceSide.black,
      assets: 'assets/icons/ic_king_black.svg',
    );
    // King white
    boards[7][4] = ChessPiece(
      type: ChessPieceType.king,
      side: ChessPieceSide.white,
      assets: 'assets/icons/ic_king_white.svg',
    );
  }

  bool _isInBoard(int row, int colum) {
    return row >= 0 && row <= 7 && colum >= 0 && colum <= 7;
  }

  bool _isInValidMoves(int row, int colum) {
    return validMoves.any((element) => element[0] == row && element[1] == colum);
  }

  void _validMoves(int row, int colum, ChessPiece? piece) {
    List<List<int>> _validMoves = [];

    switch (selectedPiece?.type) {
      case ChessPieceType.pawn:
        int direction = selectedPiece?.side == ChessPieceSide.black ? 1 : -1;

        // pawns can move forward if square is not occupied
        if (_isInBoard(row + direction, colum) && boards[row + direction][colum] == null) {
          _validMoves.add([row + direction, colum]);
        }
        // pawns can move 2 squares forward if they are at their inital position
        if (row == 1 && piece?.side == ChessPieceSide.black ||
            row == 6 && piece?.side == ChessPieceSide.white) {
          if (boards[row + direction][colum] == null &&
              boards[row + 2 * direction][colum] == null) {
            _validMoves.add([row + 2 * direction, colum]);
          }
        }
        // pawn can kill diagonally
        if (_isInBoard(row + direction, colum - 1) &&
            boards[row + direction][colum - 1] != null &&
            boards[row + direction][colum - 1]?.side != piece?.side) {
          _validMoves.add([row + direction, colum - 1]);
        }
        if (_isInBoard(row + direction, colum + 1) &&
            boards[row + direction][colum + 1] != null &&
            boards[row + direction][colum + 1]?.side != piece?.side) {
          _validMoves.add([row + direction, colum + 1]);
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
            int nextRow = row + i * direction[0];
            int nextColum = colum + i * direction[1];
            if (!_isInBoard(nextRow, nextColum)) {
              break; // out boards
            }
            if (boards[nextRow][nextColum] != null) {
              if (boards[nextRow][nextColum]?.side != piece?.side) {
                _validMoves.add([nextRow, nextColum]);
              }
              break; // blocked
            }
            _validMoves.add([nextRow, nextColum]);
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
          int nextRow = row + move[0];
          int nextColum = colum + move[1];
          if (!_isInBoard(nextRow, nextColum)) {
            continue; // out boards
          }
          if (boards[nextRow][nextColum] != null) {
            if (boards[nextRow][nextColum]?.side != piece?.side) {
              _validMoves.add([nextRow, nextColum]);
            }
            continue; // blocked
          }
          _validMoves.add([nextRow, nextColum]);
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
            int nextRow = row + i * direction[0];
            int nextColum = colum + i * direction[1];
            if (!_isInBoard(nextRow, nextColum)) {
              break; // out boards
            }
            if (boards[nextRow][nextColum] != null) {
              if (boards[nextRow][nextColum]?.side != piece?.side) {
                _validMoves.add([nextRow, nextColum]);
              }
              break; // blocked
            }
            _validMoves.add([nextRow, nextColum]);
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
            int nextRow = row + i * direction[0];
            int nextColum = colum + i * direction[1];
            if (!_isInBoard(nextRow, nextColum)) {
              break; // out boards
            }
            if (boards[nextRow][nextColum] != null) {
              if (boards[nextRow][nextColum]?.side != piece?.side) {
                _validMoves.add([nextRow, nextColum]);
              }
              break; // blocked
            }
            _validMoves.add([nextRow, nextColum]);
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
            int nextRow = row + i * direction[0];
            int nextColum = colum + i * direction[1];
            if (!_isInBoard(nextRow, nextColum)) {
              break; // out boards
            }
            if (boards[nextRow][nextColum] != null) {
              if (boards[nextRow][nextColum]?.side != piece?.side) {
                _validMoves.add([nextRow, nextColum]);
              }
              break; // blocked
            }
            _validMoves.add([nextRow, nextColum]);
            i++;
          }
        }
        break;
      default:
        break;
    }
    validMoves = _validMoves;
  }

  void _seletedPiece(int row, int colum) {
    setState(() {
      // If select a spot without any piece and is not in valid moves -> reset selections.
      if (boards[row][colum] == null && !_isInValidMoves(row, colum)) {
        selectedRow = -1;
        selectedColum = -1;
        selectedPiece = null;
        validMoves = [];
        return;
      }

      // Select piece when not selected.
      if (selectedPiece == null && boards[row][colum] != null) {
        if (boards[row][colum]?.side == currentTurn) {
          selectedRow = row;
          selectedColum = colum;
          selectedPiece = boards[row][colum];
        }
      }
      // Select piece when selected -> change select other piece.
      else if (boards[row][colum] != null && boards[row][colum]?.side == selectedPiece?.side) {
        selectedRow = row;
        selectedColum = colum;
        selectedPiece = boards[row][colum];
      }
      // Move piece
      else if (selectedPiece != null && _isInValidMoves(row, colum)) {
        _movePiece(row, colum);
      }
      _validMoves(selectedRow, selectedColum, selectedPiece);
    });
  }

  void _movePiece(int newRow, int newColum) {
    // If the new spot has an enemy piece.
    if (boards[newRow][newColum] != null) {
      ChessPiece capturedPiece = boards[newRow][newColum]!;
      if (capturedPiece.side == ChessPieceSide.white) {
        whitePiecesTeken.add(capturedPiece);
      } else {
        blackPiecesTeken.add(capturedPiece);
      }
    }

    // Move the piece and clear the old spot.
    boards[newRow][newColum] = selectedPiece;
    boards[selectedRow][selectedColum] = null;

    // Switch turn
    if (currentTurn == ChessPieceSide.white) {
      currentTurn = ChessPieceSide.black;
    } else {
      currentTurn = ChessPieceSide.white;
    }

    // Clear selection.
    setState(() {
      selectedRow = -1;
      selectedColum = -1;
      selectedPiece = null;
      validMoves = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Column(
                children: [
                  Expanded(child: Container()),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    width: double.infinity,
                    child: Wrap(
                      children: blackPiecesTeken
                          .map((piece) => SvgPicture.asset(
                                piece.assets,
                                height: 32,
                                width: 32,
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(12),
              decoration: ShapeDecoration(
                color: AppColors.white.withOpacity(0.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: GridView.builder(
                    itemCount: 8 * 8,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8),
                    itemBuilder: (context, index) {
                      // Get the row and colum position of this square
                      // [0:0] - [0:1] - [0:2] - [0:3] - [0:4] - [0:5] - [0:6] - [0:7]
                      // ...
                      // [7:0] - [7:1] - [7:2] - [7:3] - [7:4] - [7:5] - [7:6] - [7:7]
                      int row = index ~/ 8;
                      int colum = index % 8;

                      bool isSelected = row == selectedRow && colum == selectedColum;

                      bool isValidMove = false;
                      for (List<int> position in validMoves) {
                        if (position[0] == row && position[1] == colum) {
                          isValidMove = true;
                        }
                      }
                      return SquareWidget(
                        type: (row + colum) % 2 == 0 ? SquareType.white : SquareType.black,
                        piece: boards[row][colum],
                        isSelected: isSelected,
                        isValidMove: isValidMove,
                        onTap: () => _seletedPiece(row, colum),
                      );
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    width: double.infinity,
                    child: Wrap(
                      alignment: WrapAlignment.end,
                      children: whitePiecesTeken
                          .map((piece) => SvgPicture.asset(
                                piece.assets,
                                height: 32,
                                width: 32,
                              ))
                          .toList(),
                    ),
                  ),
                  Expanded(child: Container()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
