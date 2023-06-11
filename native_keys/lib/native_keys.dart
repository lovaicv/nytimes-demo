import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:flutter/services.dart';

final DynamicLibrary nativeKeysLib = Platform.isAndroid ? DynamicLibrary.open("libnative_keys.so") : DynamicLibrary.process();
final int Function(int x, int y) nativeAdd = nativeKeysLib.lookup<NativeFunction<Int32 Function(Int32, Int32)>>("native_add").asFunction();

typedef functionPointer = Pointer<Utf8> Function();

final functionPointer eykFunction = nativeKeysLib.lookup<NativeFunction<functionPointer>>('eyk').asFunction<functionPointer>();
final String eyk = eykFunction().toDartString();

final functionPointer viFunction = nativeKeysLib.lookup<NativeFunction<functionPointer>>('vi').asFunction<functionPointer>();
final String vi = viFunction().toDartString();

final functionPointer kaepyiFunction = nativeKeysLib.lookup<NativeFunction<functionPointer>>('kaepyi').asFunction<functionPointer>();
final String kaepyi = kaepyiFunction().toDartString();

class NativeKeys {
  static const MethodChannel _channel = const MethodChannel('native_keys');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
