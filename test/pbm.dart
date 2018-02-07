library testpbm;

import 'dart:io';
import 'dart:async';
import 'dart:mirrors';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:escpos/src/pbm.dart' show PBM;


void main() {
  group('pbm', () {
    test('Can read pbm', () async {
      var pathToThisFile = currentMirrorSystem().findLibrary(const Symbol('testpbm')).uri.toString();
      var pathToImagePbm = p.normalize(p.join(pathToThisFile, '../../tool/data/image.pbm')).split(':')[1];

      print(pathToImagePbm);
      Stream<List<int>> stream = new File(pathToImagePbm).openRead();
      PBM pbm = await PBM.create(stream);
    });
  });
}