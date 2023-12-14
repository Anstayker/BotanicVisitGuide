// import 'package:botanic_visit_guide/features/zone_creator/data/datasources/remote/zone_creator_remote_datasource.dart';
// import 'package:botanic_visit_guide/features/zone_creator/data/models/waypoint_info_model.dart';
// import 'package:botanic_visit_guide/features/zone_creator/data/models/zone_info_model.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';

// class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

// class MockCollectionReference extends Mock implements CollectionReference {}

// class MockDocumentReference extends Mock implements DocumentReference {}

// void main() {
//   late ZoneCreatorRemoteDatasourceImpl datasource;
//   late MockFirebaseFirestore mockFirebaseFirestore;
//   late MockCollectionReference mockCollectionReference;
//   late MockDocumentReference mockDocumentReference;

//   setUp(() {
//     mockFirebaseFirestore = MockFirebaseFirestore();
//     mockCollectionReference = MockCollectionReference();
//     mockDocumentReference = MockDocumentReference();
//     datasource =
//         ZoneCreatorRemoteDatasourceImpl(firestore: mockFirebaseFirestore);

//     when(() => mockFirebaseFirestore.collection(any())).thenReturn(
//         mockCollectionReference as CollectionReference<Map<String, dynamic>>);
//     when(() => mockCollectionReference.doc(any()))
//         .thenReturn(mockDocumentReference);
//   });

//   const tWaypointModel = WaypointInfoModel(
//       waypointId: 'waypointId', latitude: 1.0, longitude: 1.0);
//   const tZoneInfoModel = ZoneInfoModel(
//     zoneId: '123', name: 'null', waypoints: [tWaypointModel],
//     // Agrega aquí los otros campos de ZoneInfoModel
//   );

//   group('addNewZone', () {
//     test('should return true when call to firestore is successful', () async {
//       when(() => mockDocumentReference.set(any)).thenAnswer((_) async => null);

//       final result = await datasource.addNewZone(tZoneInfoModel);

//       verify(() => mockDocumentReference.set(tZoneInfoModel.toJson()));
//       expect(result, equals(true));
//     });

//     test('should return false when call to firestore throws an exception',
//         () async {
//       when(() => mockDocumentReference.set(any)).thenThrow(Exception());

//       final result = await datasource.addNewZone(tZoneInfoModel);

//       verify(() => mockDocumentReference.set(tZoneInfoModel.toJson()));
//       expect(result, equals(false));
//     });
//   });

// }
