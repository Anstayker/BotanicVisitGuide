import 'package:botanic_visit_guide/features/zone_creator/domain/entities/zone_info.dart';

class ZoneModel extends ZoneInfo {
  const ZoneModel({required id, required name, required waypoints})
      : super(id: id, name: name, waypoints: waypoints);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'waypoints': waypoints,
    };
  }

  static ZoneInfo fromMap(Map<String, dynamic> map) {
    return ZoneInfo(
      id: map['id'],
      name: map['name'],
      waypoints: map['waypoints'],
    );
  }
}
