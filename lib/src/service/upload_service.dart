import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class UploadService {
  static final _instance = FirebaseStorage.instance;

  static Future<String> uploadImage(File file) async {
    try {
      final name = DateTime.now().toIso8601String();
      final response = await _instance.ref('uploads/$name').putFile(file);
      return await response.ref.getDownloadURL();
    } on FirebaseException catch (e) {
      rethrow;
    } catch (_) {
      rethrow;
    }
  }
}
