import '../utils/index.dart';

class Day02 extends GenericDay {
  Day02() : super(2);

  @override
  List<Tuple2<String, String>> parseInput() {
    final lines = input.getPerLine().where((line) => line.isNotEmpty);
    return lines.map((line) {
      final parts = line.split(' ');
      return Tuple2(parts[0], _normalizeOther(parts[1]));
    }).toList();
  }

  @override
  int solvePart1() {
    final games = parseInput();
    return games.fold<int>(0, (acc, game) => acc + _scoreForGamePart1(game));
  }

  @override
  int solvePart2() {
    final games = parseInput();
    return games.fold<int>(0, (acc, game) {
      final own = _formToChoose(game);
      final transformedToPart1 = game.withItem2(own);
      return acc + _scoreForGamePart1(transformedToPart1);
    });
  }

  int _scoreForGamePart1(Tuple2<String, String> game) {
    return _ownScore(game.item2) + _matchScore(game);
  }

  int _ownScore(String own) {
    switch (own) {
      case 'A':
        return 1;
      case 'B':
        return 2;
      case 'C':
        return 3;
      default:
        throw Exception();
    }
  }

  int _matchScore(Tuple2<String, String> game) {
    if (game.item1 == game.item2) return 3;
    final didWin = [
      game.item2 == 'A' && game.item1 == 'C',
      game.item2 == 'B' && game.item1 == 'A',
      game.item2 == 'C' && game.item1 == 'B',
    ].any((e) => e);
    return didWin ? 6 : 0;
  }

  String _normalizeOther(String other) {
    switch (other) {
      case 'X':
        return 'A';
      case 'Y':
        return 'B';
      case 'Z':
        return 'C';
      default:
        throw Exception();
    }
  }

  String _formToChoose(Tuple2<String, String> game) {
    final other = game.item1;
    final shouldWin = game.item2 == 'C';
    final shouldDraw = game.item2 == 'B';

    if (shouldDraw) return other;

    switch (other) {
      case 'A':
        return shouldWin ? 'B' : 'C';
      case 'B':
        return shouldWin ? 'C' : 'A';
      case 'C':
        return shouldWin ? 'A' : 'B';
      default:
        throw Exception();
    }
  }
}
