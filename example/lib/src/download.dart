@JS()
library js;

import 'dart:typed_data';
import 'package:js/js.dart';

@JS('downloadBlob')
external void _download(Uint8List data, String name, String mime);

const String _binaryMime = 'application/octet-stream';

Future<void> saveOrDownload(Uint8List data) async {
  _download(data, 'output.wav', _binaryMime);
}
