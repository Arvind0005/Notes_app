import 'package:encrypt/encrypt.dart';
import 'package:sample_project/Data/EncryptionModes.dart';

class EncryptionData {
  static const encryptionKey = "E4rqzxa37VCwz7I/enrUy1S/xwH6BR==";
  static const encryptionIV = "Hkald6&ksl#usk9@";
  EncryptionModes encryptionModes = EncryptionModes();

  encryptData({required String text, AESMode? aesmode}) {
    final key = Key.fromBase64(encryptionKey);

    final iv = IV.fromLength(16);

    final encrypter = Encrypter(AES(key,
        mode: aesmode ?? AESMode.cbc, padding: EncryptionModes.AESPADDING));
    ;

    final encrypted = encrypter.encrypt(text, iv: iv);
    print(
        "$text has been encrypted , and this is the value ${encrypted.base64}");

    return encrypted.base64;
  }

  decryptData(String text, AESMode _aesmode) {
    final key = Key.fromBase64(encryptionKey);

    final iv = IV.fromBase64(encryptionIV);

    final encrypter = Encrypter(AES(key, mode: _aesmode, padding: "PKCS7"));

    final decrypted = encrypter.decrypt(Encrypted.from64(text), iv: iv);

    return decrypted;
  }
}
