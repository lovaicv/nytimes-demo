import 'package:encrypt/encrypt.dart';
import 'package:native_keys/native_keys.dart';

/// The `Constant` class provides static methods and properties related to encryption and key management.
class Constant {
  static Key key = Key.fromBase64(eyk);
  static IV iv = IV.fromBase64(vi);
  static Encrypter encrypter = Encrypter(AES(key));

  /// Retrieves the API key after decrypting it.
  static getApiKey() {
    String decrypted = encrypter.decrypt64(kaepyi, iv: iv);
    return decrypted;
  }
}
