import 'package:botanic_visit_guide/core/errors/exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/zone_data_model.dart';

abstract class ZoneFinderRemoteDataSource {
  Future<List<ZoneDataModel>> getAllZones();
  Future<ZoneDataModel> getZoneData(String zoneId);
}

class ZoneFinderRemoteDataSourceImpl implements ZoneFinderRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  ZoneFinderRemoteDataSourceImpl(
      {required this.firestore, required this.storage});

  @override
  Future<List<ZoneDataModel>> getAllZones() async {
    QuerySnapshot querySnapshot = await firestore.collection('zones').get();
    return querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return ZoneDataModel.fromJson(data);
    }).toList();
  }

  @override
  Future<ZoneDataModel> getZoneData(String zoneId) async {
    DocumentSnapshot docSnapshot =
        await firestore.collection('zones').doc(zoneId).get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
      return ZoneDataModel.fromJson(data);
    } else {
      throw NotFoundException('Zone not found');
    }
  }
}
