enum ChessPieceSide { white, black }

extension ChessPieceSideEX on ChessPieceSide {
  static ChessPieceSide? fromString(String? string) {
    switch (string?.toLowerCase()) {
      case 'white':
        return ChessPieceSide.white;
      case 'black':
        return ChessPieceSide.black;
      default:
        return null;
    }
  }
}
