import 'package:encrypt/encrypt.dart';
import 'package:native_keys/native_keys.dart';

class Constant {
  static Key key = Key.fromBase64('$eyk');
  static IV iv = IV.fromBase64('$vi');
  static Encrypter encrypter = Encrypter(AES(key));

  static getApiKey() {
    String decrypted = encrypter.decrypt64('$kaepyi', iv: iv);
    return decrypted;
  }
}
