import '../utils/index.dart';
import '../utils/stack.dart';

typedef Cargo = List<Stack<String>>;
typedef Manual = List<Instruction>;

class Day05 extends GenericDay {
  Day05() : super(5);

  @override
  Tuple2<Cargo, Manual> parseInput() {
    final lines = input.getPerLine();
    // above is the cargo, below the manual
    final divider = lines.indexOf('');

    final stackLabelString = lines[divider - 1];
    final numStacks = _getNumStacks(stackLabelString);
    final stacks = List.generate(numStacks, (i) => Stack<String>());

    for (var i = divider - 2; i >= 0; --i) {
      for (var j = 0; j < stacks.length; ++j) {
        final charPos = 1 + j * 4;
        final crate = lines[i][charPos];
        if (crate != ' ') {
          stacks[j].push(crate);
        }
      }
    }

    final instructions = _getInstructions(lines, divider).toList();
    return Tuple2(stacks, instructions);
  }

  @override
  int solvePart1() {
    print('Solution for day 5 is a string and I cant be bothered to change '
        'whole structure, thus it is just additionally printed.\n');

    // ffs dart add record type and desctructuring
    final input = parseInput();
    final cargo = input.item1;
    final manual = input.item2;

    for (final instruction in manual) {
      for (int i = 0; i < instruction.amount; ++i) {
        final crate = cargo[instruction.fromIndex].pop();
        cargo[instruction.toIndex].push(crate);
      }
    }

    final tops = cargo.map((c) => c.top());
    final result = tops.join();
    print(result);
    return 0;
  }

  @override
  int solvePart2() {
    final input = parseInput();
    final cargo = input.item1;
    final manual = input.item2;

    for (final instruction in manual) {
      final temp = <String>[];
      for (int i = 0; i < instruction.amount; ++i) {
        final crate = cargo[instruction.fromIndex].pop();
        temp.add(crate);
      }
      for (final c in temp.reversed) {
        cargo[instruction.toIndex].push(c);
      }
    }

    final tops = cargo.map((c) => c.top());
    final result = tops.join();
    print(result);

    return 0;
  }

  int _getNumStacks(String stackLabelString) {
    final stackStringLength = stackLabelString.length;
    return (stackStringLength / 4).ceil();
  }

  Iterable<Instruction> _getInstructions(
    List<String> lines,
    int divider,
  ) sync* {
    final manualRegex = RegExp(r"move (\d+) from (\d+) to (\d+)");

    // parse bottom up to create stack
    for (var i = divider + 1; i < lines.length; ++i) {
      // fml dart regex is painful, next time imma hardcode the parsing
      final parts = manualRegex.firstMatch(lines[i])!;
      final amount = int.parse(parts.group(1)!);
      final from = int.parse(parts.group(2)!);
      final to = int.parse(parts.group(3)!);

      yield Instruction(
        amount: amount,
        fromIndex: from - 1,
        toIndex: to - 1,
      );
    }
  }
}

class Instruction {
  Instruction({
    required this.amount,
    required this.fromIndex,
    required this.toIndex,
  });

  int amount;
  int fromIndex;
  int toIndex;
}
