import '../utils/index.dart';

class Day08 extends GenericDay {
  Day08() : super(8);

  @override
  Field<int> parseInput() {
    return IntegerField.fromString(input.asString);
  }

  @override
  int solvePart1() {
    final field = parseInput();

    return field.fold<int>(0, (acc, pos) {
      if (field.isOnEdge(pos)) return ++acc;

      final value = field.getValueAtPosition(pos);

      final splits = _getSplits(field, pos);
      final isVisible = splits.any((split) {
        return split.every((tree) => tree < value);
      });
      return isVisible ? ++acc : acc;
    });
  }

  @override
  int solvePart2() {
    final field = parseInput();

    final scoreField = field.map<int>((pos) {
      if (field.isOnEdge(pos)) return 0;
      final value = field.getValueAtPosition(pos);

      final splits = _getSplits(field, pos);

      final individualScores = splits.map((split) {
        final smallerConsecutiveTrees = split.takeWhile((tree) {
          return value > tree;
        }).length;

        return smallerConsecutiveTrees != split.length
            ? smallerConsecutiveTrees + 1
            : smallerConsecutiveTrees;
      });
      return individualScores.reduce((acc, score) => acc * score);
    });
    return scoreField.maxValue;
  }

  /// Returns 4 Iterables, each containing a list of the tree in one direction
  /// from given position. The lists are ordered from the position to the edge.
  List<Iterable<int>> _getSplits(Field<int> field, Position pos) {
    final colSplits = field
        .getColumn(pos.x)
        .splitAfterIndexed((i, val) => i == pos.y)
        .toList();
    colSplits[0].removeLast();

    final rowSplits =
        field.getRow(pos.y).splitAfterIndexed((i, val) => i == pos.x).toList();
    rowSplits[0].removeLast();

    return [
      colSplits[0].reversed,
      colSplits[1],
      rowSplits[0].reversed,
      rowSplits[1]
    ];
  }
}
