import 'dart:collection';

import '../utils/index.dart';

class Day06 extends GenericDay {
  Day06() : super(6);

  @override
  String parseInput() {
    return input.asString;
  }

  @override
  int solvePart1() {
    return _solve(4);
  }

  @override
  int solvePart2() {
    return _solve(14);
  }

  int _solve(int packetLength) {
    final input = parseInput();
    final queue = ListQueue<String>();

    for (int i = 0; i < input.length; i++) {
      queue.add(input[i]);

      if (queue.length > packetLength) {
        queue.removeFirst();
      }

      if (queue.toSet().length == packetLength) {
        return i + 1;
      }
    }
    throw Exception('No solution found');
  }
}
