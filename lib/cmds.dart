import 'package:charcode/ascii.dart';


List<int> initializePrinter() {
  return const [$esc, $at];
}


List<int> characterSize(int width, int height) {
  return [$gs, $exclamation, width + height];
}