import '../utils/index.dart';

class Day10 extends GenericDay {
  Day10() : super(10);

  @override
  List<_Instruction> parseInput() {
    return input.getPerLine().map((l) {
      final parts = l.split(' ');
      final isNoop = parts[0] == 'noop';
      final value = isNoop ? null : int.tryParse(parts[1]);
      return _Instruction(value);
    }).toList();
  }

  @override
  int solvePart1() {
    final instructions = parseInput();
    var register = 1;
    var cycle = 0;
    var signalStrengths = 0;
    final addToSignalStrengths = () {
      if (cycle % 40 == 20) {
        signalStrengths += cycle * register;
      }
    };

    instructions.forEach((instr) {
      ++cycle;
      addToSignalStrengths();
      if (!instr.isNoop) {
        cycle++;
        addToSignalStrengths();
        register += instr.value!;
      }
    });

    return signalStrengths;
  }

  @override
  int solvePart2() {
    final instructions = parseInput();
    var register = 1;
    var cycle = 0;
    var crtCycle = 0;
    final sb = StringBuffer();

    final drawPixel = () {
      ++cycle;
      if (register == crtCycle - 1 ||
          register == crtCycle ||
          register == crtCycle + 1) {
        sb.write('#');
      } else {
        sb.write('.');
      }
      ++crtCycle;
      if (cycle % 40 == 0) {
        sb.write("\n");
        crtCycle = 0;
      }
    };

    instructions.forEach((instr) {
      drawPixel();
      if (!instr.isNoop) {
        drawPixel();
        register += instr.value!;
      }
    });

    print(sb.toString());
    return 0;
  }
}

class _Instruction {
  final int? value;

  _Instruction(this.value);

  bool get isNoop => value == null;
}
