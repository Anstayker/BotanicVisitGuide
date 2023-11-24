import 'package:equatable/equatable.dart';

class ZoneCreator extends Equatable {
  final int zoneId;
  final String zoneName;

  const ZoneCreator({
    required this.zoneId,
    required this.zoneName,
  });

  @override
  List<Object?> get props => [zoneId, zoneName];
}
