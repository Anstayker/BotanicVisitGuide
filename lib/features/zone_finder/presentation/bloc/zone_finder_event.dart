part of 'zone_finder_bloc.dart';

sealed class ZoneFinderEvent extends Equatable {
  const ZoneFinderEvent();

  @override
  List<Object> get props => [];
}

class GetAllZonesEvent extends ZoneFinderEvent {}

class GetZoneData extends ZoneFinderEvent {
  final String zoneId;

  const GetZoneData({required this.zoneId});
}
