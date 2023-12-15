import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

import '../../../../../core/errors/exceptions.dart';
import '../../models/zone_info_model.dart';

abstract class ZoneCreatorRemoteDatasource {
  Future<bool> addNewZone(ZoneInfoModel zone,
      [List<File>? images, File? audio]);
  Future<bool> deleteZone(String zoneId);
  Future<bool> updateZone(ZoneInfoModel zone);
  Future<List<ZoneInfoModel>> getAllZones();
  Future<List<String>> getAllImages(String zoneId);
}

class ZoneCreatorRemoteDatasourceImpl implements ZoneCreatorRemoteDatasource {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  ZoneCreatorRemoteDatasourceImpl(
      {required this.firestore, required this.storage});

  @override
  Future<bool> addNewZone(ZoneInfoModel zone,
      [List<File>? images, File? audioFile]) async {
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

          // Esperar a que la tarea de subida se complete
          await uploadTask;

          // Obtener la URL de la imagen subida
          String imageUrl = await firebaseStorageRef.getDownloadURL();

          // Agregar la URL de la imagen a la lista
          imageUrls.add(imageUrl);
        }
      }

      // Subir el archivo de audio a Firebase Storage si se proporcionó
      if (audioFile != null) {
        final firebaseStorageRef = storage
            .ref()
            .child('zones/${zone.zoneId}/${path.basename(audioFile.path)}');
        UploadTask uploadTask = firebaseStorageRef.putFile(audioFile);

        // Esperar a que la tarea de subida se complete
        await uploadTask;

        // Obtener la URL del audio subido
      }

      // Agregar las URLs de las imágenes al objeto Zone

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
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        // var test = getAllImages(doc.id);
        // print(test);

        return ZoneInfoModel.fromJson(data);
      }).toList();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<String>> getAllImages(String zoneId) async {
    try {
      // Obtener el documento de la zona
      DocumentSnapshot doc =
          await firestore.collection('zones').doc(zoneId).get();
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      // Obtener la lista de nombres de las imágenes
      List<String> imageNames = List<String>.from(data['images'] ?? []);

      // Obtener las URLs de descarga de las imágenes
      List<String> imageUrls = await Future.wait(imageNames.map((name) async {
        try {
          // Crear una referencia a la imagen en Firebase Storage
          final ref = storage.ref().child('zones/$zoneId/$name');
          String url = await ref.getDownloadURL();
          return url;
        } catch (e) {
          return '';
        }
      }));

      return imageUrls;
    } catch (e) {
      throw ServerException();
    }
  }
}
