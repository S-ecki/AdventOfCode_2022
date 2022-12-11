import '../utils/index.dart';

enum Step { R, U, L, D }

class Day09 extends GenericDay {
  Day09() : super(9);

  @override
  List<Step> parseInput() {
    final nestedSteps = input.getPerLine().map((e) {
      final parts = e.split(' ');
      final reps = int.parse(parts[1]);
      Step? step;
      switch (parts[0]) {
        case 'R':
          step = Step.R;
          break;
        case 'U':
          step = Step.U;
          break;
        case 'L':
          step = Step.L;
          break;
        case 'D':
          step = Step.D;
          break;
      }
      return List.generate(reps, (_) => step!);
    }).toList();
    return nestedSteps.flattened.toList();
  }

  @override
  int solvePart1() {
    final steps = parseInput();
    final Set<Position> visited = {};
    var head = Position(0, 0);
    var tail = Position(0, 0);

    for (final step in steps) {
      head = _moveHead(head, step);
      tail = _moveTail(head, tail);
      visited.add(tail);
    }

    return visited.length;
  }

  @override
  int solvePart2() {
    final steps = parseInput();
    final Set<Position> visited = {};
    // includes head
    final knotLength = 10;
    final knots = List.generate(knotLength, (index) => Position(0, 0));

    for (final step in steps) {
      knots[0] = _moveHead(knots[0], step);

      for (int i = 1; i < knotLength; ++i) {
        knots[i] = _moveTail(knots[i - 1], knots[i]);
      }

      visited.add(knots[knotLength - 1]);
    }

    return visited.length;
  }

  Position _moveHead(Position head, Step step) {
    switch (step) {
      case Step.R:
        return Position(head.x + 1, head.y);
      case Step.U:
        return Position(head.x, head.y + 1);
      case Step.L:
        return Position(head.x - 1, head.y);
      case Step.D:
        return Position(head.x, head.y - 1);
    }
  }

  Position _moveTail(Position head, Position tail) {
    if (tail.isNeighbourOf(head)) return tail;

    final diffX = head.x - tail.x;
    final diffY = head.y - tail.y;

    return Position(tail.x + (diffX / 2).round(), tail.y + (diffY / 2).round());
  }
}
