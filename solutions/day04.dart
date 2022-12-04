import '../utils/index.dart';

typedef Section = Tuple2<int, int>;
typedef Pair = Tuple2<Section, Section>;

class Day04 extends GenericDay {
  Day04() : super(4);

  @override
  List<Pair> parseInput() {
    final lines = input.getPerLine();
    return lines.map((line) {
      final rawSections = line.split(',');
      final sections = rawSections.map((section) {
        final parts = section.split('-');
        final intParts = ParseUtil.stringListToIntList(parts);
        return Section(intParts[0], intParts[1]);
      }).toList();
      return Pair(sections[0], sections[1]);
    }).toList();
  }

  @override
  int solvePart1() {
    final pairs = parseInput();
    final containedPairs = pairs.where(_fullyContained);
    return containedPairs.length;
  }

  @override
  int solvePart2() {
    final pairs = parseInput();
    final containedPairs = pairs.where(_kindaContained);
    return containedPairs.length;
  }

  bool _fullyContained(Pair pair) {
    final leftStart = pair.item1.item1;
    final leftEnd = pair.item1.item2;
    final rightStart = pair.item2.item1;
    final rightEnd = pair.item2.item2;

    final rightContained = leftStart <= rightStart && leftEnd >= rightEnd;
    final leftContained = rightStart <= leftStart && rightEnd >= leftEnd;

    return rightContained || leftContained;
  }

  bool _kindaContained(Pair pair) {
    final leftStart = pair.item1.item1;
    final leftEnd = pair.item1.item2;
    final rightStart = pair.item2.item1;
    final rightEnd = pair.item2.item2;

    final leftKindaContained =
        !(leftStart > rightEnd) && !(leftEnd < rightStart);
    final rightKindaContained =
        !(rightStart > leftEnd) && !(rightEnd < leftStart);

    return leftKindaContained || rightKindaContained;
  }
}
