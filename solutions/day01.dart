import '../utils/index.dart';

class Day01 extends GenericDay {
  Day01() : super(1);

  @override
  List<List<int>> parseInput() {
    final lines = input.getPerLine();
    final whiteIndices = lines
        .mapIndexed((i, line) {
          if (line.isEmpty) return i;
        })
        .whereNotNull()
        .toList();
    final groupedLines = <List<int>>[];
    for (int i = 0; i < whiteIndices.length - 1; i++) {
      final sublist = lines.sublist(whiteIndices[i] + 1, whiteIndices[i + 1]);
      final parsedSublist = ParseUtil.stringListToIntList(sublist);
      groupedLines.add(parsedSublist);
    }
    return groupedLines;
  }

  @override
  int solvePart1() {
    final counts = _getCounts();
    return max<int>(counts)!;
  }

  @override
  int solvePart2() {
    final counts = _getCounts();
    counts.sort(((a, b) => b.compareTo(a)));
    return counts.take(3).sum;
  }

  List<int> _getCounts() {
    final groups = parseInput();
    return groups.map((group) => group.sum).toList();
  }
}
