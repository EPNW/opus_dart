import 'package:example/example.dart';
import 'package:opus_dart/opus_dart.dart';

Future<void> main() async {
  await initFfi();
  initOpus(openOpus());
  print(getOpusVersion());
}
