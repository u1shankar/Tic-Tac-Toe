class Player {
  static const x = "X";
  static const o = "O";
  static const empty = "";
}

class Game {
  static const blength = 9;
  static const bsize = 100.0;

  List<String>? board;
  static List<String> initGameboard() =>
      List.generate(blength, (index) => Player.empty);

  bool wCheck(String player, int index, List<int> scoreboard, int gridSize) {
    int row = index ~/ 3;
    int col = index % 3;
    int score = player == "X" ? 1 : -1;
    scoreboard[row] += score;
    scoreboard[gridSize + col] += score;
    if (row == col) scoreboard[2 * gridSize] += score;
    if (gridSize - 1 - col == row) scoreboard[2 * gridSize + 1] += score;

    if (scoreboard.contains(3) || scoreboard.contains(-3)) return true;
  
    return false;
  }
}
