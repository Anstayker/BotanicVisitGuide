part of 'zone_creator_bloc.dart';

sealed class ZoneCreatorEvent extends Equatable {
  const ZoneCreatorEvent();

  @override
  List<Object> get props => [];
}

class AddZoneEvent extends ZoneCreatorEvent {
  final ZoneInfo zone;
  final List<File> images;
  final File audio;

  const AddZoneEvent(
      {required this.zone, required this.images, required this.audio});
}

class GetAllZonesEvent extends ZoneCreatorEvent {}
