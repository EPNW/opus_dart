import 'dart:async';

import 'package:opus_dart/opus_dart.dart';
import 'dart:ffi';
import 'dart:io';

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

/// Get a stream, encode it and decode it, then save it to the harddrive,
/// play it using ffplay and delete it.
Future<void> example() async {
  const int sampleRate = 16000;
  const int channels = 1;
  Stream<List<int>> input =
      await new File('./test/s16le_16000hz_mono.raw').openRead();
  File file = new File('output.raw');
  IOSink output = file.openWrite();
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
  print('Playing using ffplay');
  await Process.run('ffplay', [
    '-ar',
    sampleRate.toString(),
    '-ac',
    channels.toString(),
    '-f',
    's16le',
    '-nodisp',
    '-autoexit',
    '-i',
    'output.raw'
  ]);
  await file.delete();
}
