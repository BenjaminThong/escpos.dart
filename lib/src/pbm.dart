library pbm;

import 'dart:async';
import 'dart:io';
import 'package:charcode/ascii.dart';

//const List<int> whitespace = const [$space, $cr, $lf, $tab];
const Map<int, bool> whitespace = const {
  $space: true,
  $cr: true,
  $lf: true,
  $tab: true,
  $vt: true,
  $ff: true,
};

const Map<int, bool> endComment = const {
  $cr: true,
  $lf: true,
};

const int comment = $asterisk;

class PBM {
  String magicNumber = null;
  int width = null;
  int height = null;

  List<List<int>> rows;
  List<int> row;

  /// Parses the given [fileData] as PBM image
  static Future<PBM> create(Stream<List<int>> fileData) async {
    StringBuffer buf = new StringBuffer();
    PBM res = new PBM();
    var tmpCount = 0;
    var tmpCountChar = 0;

    bool inComment = false;

    await for (var data in fileData) {
//      await stdout.write('11111111');
//      await stdout.flush();
        for (int i = 0; i < data.length; i++) {
//      for (int i = 0; i < 20; i++) {
        if (data[i] == comment) {
          inComment = true;
          continue;
        }
        if (inComment && endComment[data[i]] == true) {
          inComment = false;
          continue;
        }
        if (inComment) {
          continue;
        }

        if (whitespace[data[i]] == true && res.height == null) {
          if (buf.length > 0) {
            // reached end of field
            if (res.magicNumber == null) {
              res.magicNumber = buf.toString();
              buf.clear();
              continue;
            }
            if (res.width == null) {
              res.width = int.parse(buf.toString());
              buf.clear();
              continue;
            }
            if (res.height == null) {
              res.height = int.parse(buf.toString());
              buf.clear();
              continue;
            }
//            tmpCount ++;
//            buf.clear();
//            continue;
          }
          else {
            continue;
          }
        }

        tmpCountChar++;

        buf.writeCharCode(data[i]);




//        print(new String.fromCharCodes([data[i]]));
//          await stdout.write('${data[i]} ');
//          await stdout.flush();
//        buf.writeCharCode(data[i]);
//        tmpCount++;
//          result.add(data[i]);
//          if (data[i] == semicolon) {
//            print(new String.fromCharCodes(result));
//            return;
//          }
      }
    }
//      stdout.write(buf.toString());
//      await stdout.flush();
//    stdout.close();
    print('${res.magicNumber}  ${res.width}  ${res.height}  ${tmpCount}  ${tmpCountChar}');
    return res;
  }
}