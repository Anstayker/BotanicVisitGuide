part of 'zone_creator_bloc.dart';

sealed class ZoneCreatorEvent extends Equatable {
  const ZoneCreatorEvent();

  @override
  List<Object> get props => [];
}

class AddZoneEvent extends ZoneCreatorEvent {
  final ZoneInfo zone;
  final List<File> images;

  const AddZoneEvent({required this.zone, required this.images});
}

class GetAllZonesEvent extends ZoneCreatorEvent {}
