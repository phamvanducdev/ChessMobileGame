import 'package:chess_mobile_game/enums/chess_piece_side.dart';
import 'package:chess_mobile_game/models/game.dart';
import 'package:chess_mobile_game/shared/helper/game_helper.dart';
import 'package:chess_mobile_game/ui/game/game_bloc.dart';
import 'package:chess_mobile_game/ui/game/widgets/square.dart';
import 'package:chess_mobile_game/models/chess_piece.dart';
import 'package:chess_mobile_game/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class GameBoardWidget extends StatefulWidget {
  const GameBoardWidget({super.key});

  @override
  State<GameBoardWidget> createState() => _GameBoardWidgetState();
}

class _GameBoardWidgetState extends State<GameBoardWidget> {
  // To indicate whose turn it is
  ChessPieceSide _currentTurn = ChessPieceSide.white;

  // A 2-dimensional list representing the chessboard,
  // with each position possibly containing a chess piece.
  List<List<ChessPiece?>> _pieceOnBoardMatrix = [];

  // List of White/Black piece that have been taken by the White/Black player.
  List<ChessPiece?> _pieceTekenBlackList = [];
  List<ChessPiece?> _pieceTekenWhiteList = [];

  // The currently selected piece on the chess board,
  // If no piece is selected, this is null.
  ChessPiece? _pieceSelected;

  // The row and colum index of the selected piece
  // Default value -1 indicated no piece is currently selected.
  int _rowPieceSelected = -1;
  int _columPieceSelected = -1;

  // Valid moves for currently selected piece
  List<List<int>> _validMovePositions = [];

  bool _validMove(int row, int colum) {
    return _validMovePositions.any((element) => element[0] == row && element[1] == colum);
  }

  void _onSeletedPiece(int row, int colum) {
    setState(() {
      // If select a spot without any piece and is not in valid moves -> reset selections.
      if (_pieceOnBoardMatrix[row][colum] == null && !_validMove(row, colum)) {
        _pieceSelected = null;
        _rowPieceSelected = -1;
        _columPieceSelected = -1;
        _validMovePositions = [];
        return;
      }

      // Select piece when not selected.
      if (_pieceSelected == null && _pieceOnBoardMatrix[row][colum] != null) {
        if (_pieceOnBoardMatrix[row][colum]?.side == _currentTurn) {
          _rowPieceSelected = row;
          _columPieceSelected = colum;
          _pieceSelected = _pieceOnBoardMatrix[row][colum];
        }
      }
      // Select piece when selected -> change select other piece.
      else if (_pieceOnBoardMatrix[row][colum] != null && _pieceOnBoardMatrix[row][colum]?.side == _pieceSelected?.side) {
        _rowPieceSelected = row;
        _columPieceSelected = colum;
        _pieceSelected = _pieceOnBoardMatrix[row][colum];
      }
      // Move piece
      else if (_pieceSelected != null && _validMove(row, colum)) {
        _onMovePiece(row, colum);
      }
      // Update _validMovePositions values
      _validMovePositions = GameHelper.validMovePositions(
        _pieceOnBoardMatrix,
        _pieceSelected,
        _rowPieceSelected,
        _columPieceSelected,
      );
    });
  }

  void _onMovePiece(int newRow, int newColum) {
    // If the new spot has an enemy piece.
    if (_pieceOnBoardMatrix[newRow][newColum] != null) {
      ChessPiece capturedPiece = _pieceOnBoardMatrix[newRow][newColum]!;
      if (capturedPiece.side == ChessPieceSide.white) {
        _pieceTekenWhiteList.add(capturedPiece);
      } else {
        _pieceTekenBlackList.add(capturedPiece);
      }
    }

    // Move the piece and clear the old spot.
    _pieceOnBoardMatrix[newRow][newColum] = _pieceSelected;
    _pieceOnBoardMatrix[_rowPieceSelected][_columPieceSelected] = null;

    // Switch turn
    if (_currentTurn == ChessPieceSide.white) {
      _currentTurn = ChessPieceSide.black;
    } else {
      _currentTurn = ChessPieceSide.white;
    }

    // Clear selection.
    setState(() {
      _pieceSelected = null;
      _rowPieceSelected = -1;
      _columPieceSelected = -1;
      _validMovePositions = [];
    });

    context.read<GameBLoC>().updateGameChanged(
          _currentTurn,
          _pieceOnBoardMatrix,
          _pieceTekenBlackList,
          _pieceTekenWhiteList,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: StreamBuilder<Game>(
          stream: context.read<GameBLoC>().gameInfoStream,
          builder: (context, snapshot) {
            final gameInfo = snapshot.data;
            if (snapshot.connectionState == ConnectionState.waiting || gameInfo == null) {
              return Center(child: CircularProgressIndicator());
            }
            _pieceOnBoardMatrix = gameInfo.pieceOnBoardList;
            _pieceTekenBlackList = gameInfo.pieceTekenBlackList;
            _pieceTekenWhiteList = gameInfo.pieceTekenWhiteList;
            _currentTurn = gameInfo.currentTurn;

            return SafeArea(
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
                            children: _pieceTekenBlackList
                                .map(
                                  (piece) => piece?.assets != null
                                      ? SvgPicture.asset(piece!.assets!, height: 32.0, width: 32.0)
                                      : Container(),
                                )
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(12.0),
                    padding: const EdgeInsets.all(8.0),
                    decoration: ShapeDecoration(
                      color: AppColors.white.withOpacity(0.2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: GridView.builder(
                          itemCount: 8 * 8,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8),
                          itemBuilder: (context, index) {
                            // Get the row and colum position of this square
                            // [0:0] - [0:1] - [0:2] - [0:3] - [0:4] - [0:5] - [0:6] - [0:7]
                            // ...
                            // [7:0] - [7:1] - [7:2] - [7:3] - [7:4] - [7:5] - [7:6] - [7:7]
                            int row = index ~/ 8;
                            int colum = index % 8;

                            bool isSelected = row == _rowPieceSelected && colum == _columPieceSelected;

                            bool isValidMove = false;
                            for (List<int> position in _validMovePositions) {
                              if (position[0] == row && position[1] == colum) {
                                isValidMove = true;
                              }
                            }
                            return SquareWidget(
                              type: (row + colum) % 2 == 0 ? SquareType.white : SquareType.black,
                              piece: _pieceOnBoardMatrix[row][colum],
                              isSelected: isSelected,
                              isValidMove: isValidMove,
                              onTap: () => _onSeletedPiece(row, colum),
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
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          width: double.infinity,
                          child: Wrap(
                            alignment: WrapAlignment.end,
                            children: _pieceTekenWhiteList
                                .map(
                                  (piece) => piece?.assets != null
                                      ? SvgPicture.asset(piece!.assets!, height: 32.0, width: 32.0)
                                      : Container(),
                                )
                                .toList(),
                          ),
                        ),
                        Expanded(child: Container()),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
