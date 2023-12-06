part of 'zone_creator_bloc.dart';

sealed class ZoneCreatorEvent extends Equatable {
  const ZoneCreatorEvent();

  @override
  List<Object> get props => [];
}

class AddZoneEvent extends ZoneCreatorEvent {
  final ZoneInfo zone;

  const AddZoneEvent({required this.zone});
}

class GetAllZonesEvent extends ZoneCreatorEvent {}
