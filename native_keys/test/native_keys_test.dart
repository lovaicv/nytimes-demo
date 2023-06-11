import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:native_keys/native_keys.dart';

void main() {
  const MethodChannel channel = MethodChannel('native_keys');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await NativeKeys.platformVersion, '42');
  });
}
