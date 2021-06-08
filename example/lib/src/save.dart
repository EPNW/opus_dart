import 'dart:typed_data';
import 'dart:io';

Future<void> saveOrDownload(Uint8List data) async {
  await (new File('output.wav')).writeAsBytes(data);
}
