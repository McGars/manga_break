import 'package:encrypt/encrypt.dart';

class EncriptUseCase {
  final key = Key.fromLength(32);
  final iv = IV.fromLength(16);
  Encrypter _encrypter;

  EncriptUseCase() {
    _encrypter = Encrypter(AES(key));
  }

  String encript16(String value) {
    return _encrypter.encrypt(value, iv: iv).base16;
  }

  String encript(String value) {
    return _encrypter.encrypt(value, iv: iv).base64;
  }

  String decript16(String value) {
    return _encrypter.decrypt16(value, iv: iv);
  }

  String decript(String value) {
    return _encrypter.decrypt64(value, iv: iv);
  }

}