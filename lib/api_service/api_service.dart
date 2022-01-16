import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:owner_app/constants/constants.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ApiService {
  //firebase
  final _fireStore = FirebaseFirestore.instance;
  final userUID = FirebaseAuth.instance.currentUser?.uid;

  Future<void> create(
      {required String colect,
      required String dataID,
      required Map<String, dynamic> data}) async {
    _fireStore
        .collection(Constants.userDb)
        .doc(userUID)
        .collection(colect)
        .doc(dataID)
        .set(data);
  }

  Future<QuerySnapshot> getData({required String colect}) async {
    QuerySnapshot snap = await _fireStore
        .collection(Constants.userDb)
        .doc(userUID)
        .collection(colect)
        .get();
    return snap;
  }

  Future<void> update(
      {required String colect,
      required String dataID,
      required Map<String, dynamic> data}) async {
    _fireStore
        .collection(Constants.userDb)
        .doc(userUID)
        .collection(colect)
        .doc(dataID)
        .update(data);
  }

  Future<void> delete({required String colect, required String dataID}) async {
    _fireStore
        .collection(Constants.userDb)
        .doc(userUID)
        .collection(colect)
        .doc(dataID)
        .delete();
  }

  static Future<File?> loadFirebase(String url) async {
    try {
      final refPDF = FirebaseStorage.instance.ref('sample').child(url);
      final bytes = await refPDF.getData();

      return _storeFile(url, bytes!);
    } catch (e) {
      return null;
    }
  }

  static Future<File> _storeFile(String url, List<int> bytes) async {
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }

  static Future<String>? saveImageToStore(File? file) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref =
        storage.ref().child('Image').child(basename(file?.path ?? ''));
    UploadTask storageUploadTask = ref.putFile(file!);
    String imageUrl = await (await storageUploadTask).ref.getDownloadURL();
    return imageUrl;
  }
}
