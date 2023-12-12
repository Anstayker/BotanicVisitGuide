import 'package:botanic_visit_guide/core/errors/exceptions.dart';
import 'package:botanic_visit_guide/features/zone_creator/data/models/zone_info_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ZoneCreatorRemoteDatasource {
  Future<bool> addNewZone(ZoneInfoModel zone);
  Future<bool> deleteZone(String zoneId);
  Future<bool> updateZone(ZoneInfoModel zone);
  Future<List<ZoneInfoModel>> getAllZones();
}

class ZoneCreatorRemoteDatasourceImpl implements ZoneCreatorRemoteDatasource {
  final FirebaseFirestore firestore;

  ZoneCreatorRemoteDatasourceImpl({required this.firestore});

  @override
  Future<bool> addNewZone(ZoneInfoModel zone) async {
    try {
      await firestore.collection('zones').doc(zone.zoneId).set(zone.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteZone(String zoneId) async {
    try {
      await firestore.collection('zones').doc(zoneId).delete();
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
