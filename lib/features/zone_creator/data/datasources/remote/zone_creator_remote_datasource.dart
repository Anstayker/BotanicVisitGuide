import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

import '../../../../../core/errors/exceptions.dart';
import '../../models/zone_info_model.dart';

abstract class ZoneCreatorRemoteDatasource {
  Future<bool> addNewZone(ZoneInfoModel zone, [List<File>? images]);
  Future<bool> deleteZone(String zoneId);
  Future<bool> updateZone(ZoneInfoModel zone);
  Future<List<ZoneInfoModel>> getAllZones();
}

class ZoneCreatorRemoteDatasourceImpl implements ZoneCreatorRemoteDatasource {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  ZoneCreatorRemoteDatasourceImpl(
      {required this.firestore, required this.storage});

  @override
  Future<bool> addNewZone(ZoneInfoModel zone, [List<File>? images]) async {
    try {
      // Crear una lista para almacenar las URLs de las imágenes
      List<String> imageUrls = [];

      // Subir cada imagen a Firebase Storage solo si se proporcionaron imágenes
      if (images != null) {
        for (var image in images) {
          final firebaseStorageRef = storage
              .ref()
              .child('zones/${zone.zoneId}/${path.basename(image.path)}');
          UploadTask uploadTask = firebaseStorageRef.putFile(image);

          // Obtener la URL de la imagen
          final downloadUrl = await (await uploadTask).ref.getDownloadURL();

          // Agregar la URL de la imagen a la lista
          imageUrls.add(downloadUrl);
        }
      }

      // Agregar las URLs de las imágenes al objeto zone
      zone.images?.value = imageUrls;

      // Subir objeto Zone a Firestore
      await firestore.collection('zones').doc(zone.zoneId).set(zone.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteZone(String zoneId) async {
    try {
      // Obtener la referencia a la zona en Firestore
      DocumentReference zoneRef = firestore.collection('zones').doc(zoneId);

      // Eliminar la zona
      await zoneRef.delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> updateZone(ZoneInfoModel zone) async {
    try {
      await firestore
          .collection('zones')
          .doc(zone.zoneId)
          .update(zone.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<ZoneInfoModel>> getAllZones() async {
    try {
      QuerySnapshot snapshot = await firestore.collection('zones').get();
      return snapshot.docs
          .map((doc) =>
              ZoneInfoModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw ServerException();
    }
  }
}
