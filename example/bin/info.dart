import 'package:example/example.dart';
import 'package:opus_dart/opus_dart.dart';

void main() {
  initOpus(openOpus());
  print(getOpusVersion());
}
