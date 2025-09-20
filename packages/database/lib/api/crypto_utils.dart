import 'dart:convert';
import 'dart:io';

import 'package:encrypt/encrypt.dart' as encry;
import 'package:flutter/foundation.dart';
import 'package:utilities/utils.dart';
import 'package:pointycastle/export.dart';

/*
Author: Nagaraju.lj
Date: April,2024.
Description: Encryption and decryption utilities
 */
class Crypto {
  static const String _encryptedKey = "567gd*+n6s2kf5ub";
  static const String _encryptedInitVector = 'hdj7R3Bj3bKd8sl\$';

  static final _fileEncryptedKey = base64.decode('FgQb914mNIlnCept2LaaNQ==');
  static final _fileEncryptedInitVector = utf8.encode('4fLvTX%&B^NeYSa*');

  static encrypt(String data) {
    final key = encry.Key.fromUtf8(_encryptedKey);
    final iv = encry.IV.fromUtf8(_encryptedInitVector);
    final encrypter = encry.Encrypter(
        encry.AES(key, mode: encry.AESMode.cbc, padding: 'PKCS7'));
    return encrypter.encrypt(data, iv: iv).base64;
  }

  static decrypt(String data) {
    try {
      final key = encry.Key.fromUtf8(_encryptedKey);
      final iv = encry.IV.fromUtf8(_encryptedInitVector);
      final encrypted = encry.Encrypter(
          encry.AES(key, mode: encry.AESMode.cbc, padding: 'PKCS7'));
      final decrypted = encrypted.decrypt(encry.Encrypted.from64(data), iv: iv);

      return decrypted;
    } catch (e, stackTrace) {
      Utils.printCrashError(e.toString(), stacktrace: stackTrace);
      return data;
    }
  }

  // static Future<bool> decryptAndCopyFile(String filePath, String outputFilePath,
  //     void Function(DecryptAndCopyFileParameter) processChunk) async {
  //   try {
  //     //Utils.print("decryption started: $filePath Time ${ESDateTimeUtils().getDateTimeSync()}");
  //
  //     String decodedFilePath = Utils.decodeOfflinePath(filePath);
  //     String decodedOutputFilePath = Utils.decodeOfflinePath(outputFilePath);
  //     File encryptedFile = File(decodedFilePath);
  //
  //     if (await encryptedFile.exists()) {
  //       File outputFile  = File(decodedOutputFilePath);
  //       if(outputFile.existsSync()==false){
  //         await outputFile.create();
  //         await _chunkByChunkDecryptLargeFile(
  //             decodedFilePath, decodedOutputFilePath, processChunk);
  //       }
  //       //Utils.print("decryption ended: $filePath Time ${ESDateTimeUtils().getDateTimeSync()}")
  //       return outputFile.existsSync();
  //     } else {
  //       return false;
  //     }
  //   } catch (e, stacktrace) {
  //     Utils.printCrashError("decryption error: ${e.toString()}",
  //         stacktrace: stacktrace);
  //     return false;
  //   }
  // }

  static Future<void> _chunkByChunkDecryptLargeFile(
      String encryptedFilePath,
      String outputFilePath,
      void Function(DecryptAndCopyFileParameter) processChunk) async {
    File? encryptedFile = File(encryptedFilePath);
    const int chunkSize = 1024 * 512 * 5;
    int offset = 0;

    ///Decrypt whole file chunk by chunk
    int bytesLeft = await encryptedFile.length();
    try {
      while (bytesLeft > 0) {
        final fileReadSize = bytesLeft > chunkSize ? chunkSize : bytesLeft;
        processChunk(DecryptAndCopyFileParameter(
            inputPath: encryptedFilePath,
            chunkSize: fileReadSize,
            fileOffset: offset,
            outputPath: outputFilePath));
        bytesLeft -= fileReadSize;
        offset = offset + fileReadSize;
      }
    } catch (e, stacktrace) {
      Utils.printCrashError("decryption ${e.toString()}",
          stacktrace: stacktrace);
    }
  }

  static decryptChunkForLargeFile(DecryptAndCopyFileParameter params) async {
    final inputPath = params.inputPath;
    final chunkSize = params.chunkSize;
    final int fileOffset = params.fileOffset;
    final outputPath = params.outputPath;

    File outputFile = File(outputPath);
    RandomAccessFile inputFile =
        await File(inputPath).open(mode: FileMode.read);

    Uint8List curIvBytes = _fileEncryptedInitVector;
    if (fileOffset != 0) {
      inputFile.setPositionSync(fileOffset - 16);
      curIvBytes = await inputFile.read(16);
    } else {
      inputFile.setPositionSync(fileOffset);
    }
    Uint8List chunk = await inputFile.read(chunkSize);

    Uint8List plaintext = Uint8List(chunk.length);
    _decryptChunk(curIvBytes, chunk, plaintext);

    if ((fileOffset + chunkSize) == inputFile.lengthSync()) {
      plaintext = _removePadding(plaintext);
    }

    outputFile.openSync(mode: FileMode.append)
      ..lockSync(FileLock.blockingExclusive)
      ..setPositionSync(fileOffset)
      ..writeFromSync(plaintext)
      ..flush();
  }

  static _removePadding(Uint8List paddedPlaintext) {
    final padCount = PKCS7Padding().padCount(paddedPlaintext);
    return paddedPlaintext.sublist(0, paddedPlaintext.length - padCount);
  }

  static _decryptChunk(
      List<int> ivBytes, Uint8List chunk, Uint8List plaintext) {
    final cbc = CBCBlockCipher(AESFastEngine())
      ..init(
        false, // false = decryption
        ParametersWithIV(KeyParameter(Uint8List.fromList(_fileEncryptedKey)),
            Uint8List.fromList(ivBytes)),
      );
    int offset = 0;
    while (offset < chunk.length) {
      offset += cbc.processBlock(chunk, offset, plaintext, offset);
    }
  }

  static String? getFileName(String filePath) {
    try {
      return filePath.substring(filePath.lastIndexOf('/') + 1);
    } catch (e, stackTrace) {
      Utils.printCrashError(e.toString(), stacktrace: stackTrace);
      return null;
    }
  }
}

class DecryptAndCopyFileParameter {
  final String inputPath;
  final int chunkSize;
  final int fileOffset;
  final String outputPath;

  DecryptAndCopyFileParameter({
    required this.inputPath,
    required this.chunkSize,
    required this.fileOffset,
    required this.outputPath,
  });
}
