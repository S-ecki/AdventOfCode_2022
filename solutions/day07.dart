import '../utils/index.dart';

class Day07 extends GenericDay {
  Day07() : super(7);

  @override
  FileSystem parseInput() {
    final fs = FileSystem();
    var current = fs.root;
    for (final line in input.getPerLine()) {
      final tokens = line.split(' ');
      if (tokens[0] == '\$' && tokens[1] == 'cd') {
        if (tokens[2] == '..') {
          current = current.parent!;
        } else if (tokens[2] == '/') {
          current = fs.root;
        } else {
          fs.addDir(current, tokens[2]);
          current = current.subdirs[tokens[2]]!;
        }
      } else if (tokens[0] != '\$' && tokens[0] != 'dir') {
        current.sizeOwn += int.parse(tokens[0]);
      }
    }
    return fs;
  }

  @override
  int solvePart1() {
    final fs = parseInput();
    final dirs = fs.allDirsRec(fs.root);

    return dirs
        .where((element) => element.sizeTotal <= 100000)
        .map((e) => e.sizeTotal)
        .sum;
  }

  @override
  int solvePart2() {
    final fs = parseInput();
    final dirs = fs.allDirsRec(fs.root);
    final minDirSize = 30000000 - 70000000 + fs.root.sizeTotal;

    final relevantDirs = dirs.where((e) => e.sizeTotal >= minDirSize);
    return relevantDirs.fold<int>(
      fs.root.sizeTotal,
      (prev, d) => min([prev, d.sizeTotal])!,
    );
  }
}

// note: files are ignored, only their size matters, which gets accumulated here
class Directory {
  Directory([this.parent]);
  final Map<String, Directory> subdirs = {};
  final Directory? parent;
  // mutating like a madman
  int sizeOwn = 0;

  int get sizeTotal => sizeOwn + subdirs.values.map((e) => e.sizeTotal).sum;
}

class FileSystem {
  final Directory root = Directory();

  List<Directory> allDirsRec(Directory? current) {
    current ??= root;
    final subdirs = current.subdirs.values;

    if (subdirs.isEmpty) return [];

    final directSubdirs = subdirs;
    // even using recursion, ADS2 paid off
    final recSubdirs = subdirs.map(allDirsRec).flattened;
    return [...directSubdirs, ...recSubdirs];
  }

  void addDir(Directory parent, String name) {
    if (parent.subdirs.containsKey(name))
      throw Exception('Directory already exists: $name');
    parent.subdirs[name] = Directory(parent);
  }
}
