import 'package:chess_mobile_game/domain/models/piece.dart';
import 'package:chess_mobile_game/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum SquareType { white, black }

class SquareWidget extends StatelessWidget {
  final SquareType type;
  final ChessPiece? piece;
  final bool isSelected;
  final bool isValidMove;
  final Function() onTap;

  const SquareWidget({
    super.key,
    required this.type,
    required this.piece,
    required this.isSelected,
    required this.isValidMove,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        color: type == SquareType.white ? AppColors.boardWhite : AppColors.boardBlack,
        child: Stack(
          children: [
            isSelected ? Container(color: AppColors.boardSelected.withOpacity(0.5)) : Container(),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 4),
              child: piece != null ? SvgPicture.asset(piece!.assets) : null,
            ),
            isValidMove
                ? Center(
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: ShapeDecoration(
                        color: AppColors.boardSelected.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
