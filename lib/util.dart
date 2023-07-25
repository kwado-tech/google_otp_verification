import 'dart:math';
import 'dart:typed_data';

import 'package:base32/base32.dart';

class StringGenerators {
  static String generate() {
    // generate a cryptographically secure random byte array
    final random = Random.secure();
    final bytesList = List<int>.generate(20, (_) => random.nextInt(256));

    // encode the byte array to a base32 string
    final uint8List = Uint8List.fromList(bytesList);
  
    return base32.encode(uint8List);
  }
}
