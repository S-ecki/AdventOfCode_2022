import '../utils/index.dart';

typedef Rucksack = Tuple2<String, String>;
typedef Group = Tuple3<String, String, String>;

class Day03 extends GenericDay {
  Day03() : super(3);

  @override
  List<String> parseInput() {
    return input.getPerLine().where((l) => l.isNotEmpty).toList();
  }

  @override
  int solvePart1() {
    final lines = parseInput();
    final rucksacks = _parseRucksacks(lines);
    final commons = rucksacks.map(_commonChar);
    final priorities = commons.map(_priority);
    return priorities.sum;
  }

  @override
  int solvePart2() {
    final lines = parseInput();
    final groups = _parseGroups(lines);
    final commons = groups.map(_commonCharGroup);
    final priorities = commons.map(_priority);
    return priorities.sum;
  }

  List<Rucksack> _parseRucksacks(List<String> lines) {
    return lines.map((l) {
      final split = l.length ~/ 2;
      final firstPart = l.substring(0, split);
      final secondPart = l.substring(split);
      return Rucksack(firstPart, secondPart);
    }).toList();
  }

  String _commonChar(Rucksack rucksack) {
    for (final rune in rucksack.item1.runes) {
      final c = String.fromCharCode(rune);
      if (rucksack.item2.contains(c)) {
        return c;
      }
    }
    throw Exception('No common char found');
  }

  int _priority(String char) {
    final isCapital = char == char.toUpperCase();
    if (isCapital) {
      // 65 - 90 unicode range
      // should be priority 27 - 52
      return char.codeUnitAt(0) - 38;
    } else {
      // 97 - 122
      // should be priority 1 - 26
      return char.codeUnitAt(0) - 96;
    }
  }

  Iterable<Group> _parseGroups(List<String> lines) sync* {
    for (int i = 0; i < lines.length; i += 3) {
      final first = lines[i];
      final second = lines[i + 1];
      final third = lines[i + 2];
      yield Group(first, second, third);
    }
  }

  String _commonCharGroup(Group group) {
    for (final rune in group.item1.runes) {
      final c = String.fromCharCode(rune);
      if (group.item2.contains(c) && group.item3.contains(c)) {
        return c;
      }
    }
    throw Exception('No common char found');
  }
}
