import 'dart:async';
import 'dart:typed_data';
import 'dart:convert';
import 'dart:math';
import 'package:example/example.dart';
import 'package:opus_dart/opus_dart.dart';

/// Should be run from the example
Future<void> main() async {
  await initFfi();
  initOpus(openOpus());
  Uint8List data = await example();
  await saveOrDownload(data);
}

Stream<List<int>> simulateInput() async* {
  const int portionSize =
      65535; //equals the usual size you get per list in a network stream
  ByteData data = s16le_16000hz_mono.buffer.asByteData();
  int i = 0;
  while (i != data.lengthInBytes) {
    int r = min(portionSize, data.lengthInBytes - i);
    yield data.buffer.asUint8List(data.offsetInBytes + i, r);
    i += r;
    await new Future.delayed(
        const Duration(milliseconds: 10)); //Simulate network latency
  }
}

/// Get a stream, encode it and decode it, then save it to the harddrive
/// with a wav header.
Future<Uint8List> example() async {
  const int sampleRate = 16000;
  const int channels = 1;
  List<Uint8List> output = [];
  output.add(new Uint8List(wavHeaderSize));
  await simulateInput()
      .transform(new StreamOpusEncoder.bytes(
          floatInput: false,
          frameTime: FrameTime.ms20,
          sampleRate: sampleRate,
          channels: channels,
          application: Application.audio,
          copyOutput: true,
          fillUpLastFrame: true))
      .cast<Uint8List?>()
      .transform(new StreamOpusDecoder.bytes(
          floatOutput: false,
          sampleRate: sampleRate,
          channels: channels,
          copyOutput: true,
          forwardErrorCorrection: false))
      .cast<Uint8List>()
      .forEach(output.add);
  int length = output.fold(0, (int l, Uint8List element) => l + element.length);
  //Write the wav header
  Uint8List header =
      wavHeader(channels: channels, sampleRate: sampleRate, fileSize: length);
  output[0] = header;
  // Merge into a single Uint8List
  Uint8List flat = new Uint8List(length);
  int index = 0;
  for (Uint8List element in output) {
    flat.setAll(index, element);
    index += element.length;
  }
  return flat;
}

const int wavHeaderSize = 44;

Uint8List wavHeader(
    {required int sampleRate, required int channels, required int fileSize}) {
  const int sampleBits = 16; //We know this since we used opus
  const Endian endian = Endian.little;
  final int frameSize = ((sampleBits + 7) ~/ 8) * channels;
  ByteData data = new ByteData(wavHeaderSize);
  data.setUint32(4, fileSize - 4, endian);
  data.setUint32(16, 16, endian);
  data.setUint16(20, 1, endian);
  data.setUint16(22, channels, endian);
  data.setUint32(24, sampleRate, endian);
  data.setUint32(28, sampleRate * frameSize, endian);
  data.setUint16(30, frameSize, endian);
  data.setUint16(34, sampleBits, endian);
  data.setUint32(40, fileSize - 44, endian);
  Uint8List bytes = data.buffer.asUint8List();
  bytes.setAll(0, ascii.encode('RIFF'));
  bytes.setAll(8, ascii.encode('WAVE'));
  bytes.setAll(12, ascii.encode('fmt '));
  bytes.setAll(36, ascii.encode('data'));
  return bytes;
}
