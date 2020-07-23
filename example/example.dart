import 'dart:async';
import 'dart:typed_data';

import 'package:opus_dart/opus_dart.dart';
import 'dart:ffi';
import 'dart:io';
import 'dart:convert';

/// Should be run from the example
Future<void> main() async {
  init();
  await example();
}

void init() {
  DynamicLibrary lib;
  if (Platform.isWindows) {
    bool x64 = Platform.version.contains('x64');
    if (x64) {
      lib =
          new DynamicLibrary.open('C:/Users/Eric/Desktop/opus/libopus_x64.dll');
    } else {
      lib = new DynamicLibrary.open('path/to/libopus_x86.dll');
    }
  } else if (Platform.isLinux) {
    lib = new DynamicLibrary.open('/usr/local/lib/libopus.so');
  }
  initOpus(lib);
  print(getOpusVersion());
}

/// Get a stream, encode it and decode it, then save it to the harddrive
/// with a wav header.
Future<void> example() async {
  const int sampleRate = 16000;
  const int channels = 1;
  Stream<List<int>> input = await new File('s16le_16000hz_mono.raw').openRead();
  File file = new File('output.wav');
  IOSink output = file.openWrite();
  output.add(new Uint8List(wavHeaderSize));
  await input
      .transform(new StreamOpusEncoder.bytes(
          floatInput: false,
          frameTime: FrameTime.ms20,
          sampleRate: sampleRate,
          channels: channels,
          application: Application.audio,
          copyOutput: true,
          fillUpLastFrame: true))
      .transform(new StreamOpusDecoder.bytes(
          floatOutput: false,
          sampleRate: sampleRate,
          channels: channels,
          copyOutput: true,
          forwardErrorCorrection: false))
      .cast<List<int>>()
      .pipe(output);
  await output.close();
  //Write the wav header
  RandomAccessFile r = await file.open(mode: FileMode.append);
  await r.setPosition(0);
  Uint8List header=wavHeader(
      channels: channels,
      sampleRate: sampleRate,
      fileSize: await file.length());
  await r.writeFrom(header);
  await r.close();
  return file;
}

const int wavHeaderSize = 44;

Uint8List wavHeader({int sampleRate, int channels, int fileSize}) {
  const int sampleBits = 16; //We know this since we used opus
  const Endian endian = Endian.little;
  final int frameSize = ((sampleBits + 7) ~/ 8) * channels;
  ByteData data = new ByteData(wavHeaderSize);
  data.setUint32(4, fileSize - 4, endian);
  data.setUint32(16, 16, endian);
  data.setUint16(20, 1,endian);
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
