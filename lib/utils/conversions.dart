/// A utility class with some handy conversion methods.
class Conversions {
  /// FNV-1a 64bit hash algorithm optimized for Dart Strings.
  ///
  /// Borrowed from Isar
  static int fastHash(String string) {
    int hash = BigInt.parse('0xcbf29ce484222325').toInt();

    int i = 0;
    while (i < string.length) {
      final codeUnit = string.codeUnitAt(i++);
      hash ^= codeUnit >> 8;
      hash *= 0x100000001b3;
      hash ^= codeUnit & 0xFF;
      hash *= 0x100000001b3;
    }

    return hash;
  }
}
