part of 'zone_finder_bloc.dart';

sealed class ZoneFinderEvent extends Equatable {
  const ZoneFinderEvent();

  @override
  List<Object> get props => [];
}

class GetAllZonesEvent extends ZoneFinderEvent {}

class GetZoneDataEvent extends ZoneFinderEvent {
  final String zoneId;

  const GetZoneDataEvent({required this.zoneId});
}

class GetZoneImagesEvent extends ZoneFinderEvent {
  final String zoneId;

  const GetZoneImagesEvent({required this.zoneId});
}
