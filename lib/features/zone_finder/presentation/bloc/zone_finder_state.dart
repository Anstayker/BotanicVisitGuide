part of 'zone_finder_bloc.dart';

sealed class ZoneFinderState extends Equatable {
  const ZoneFinderState();

  @override
  List<Object> get props => [];
}

final class ZoneFinderInitial extends ZoneFinderState {}

// ! Get all Zones

class ZonesLoading extends ZoneFinderState {}

class ZonesLoadSuccess extends ZoneFinderState {
  final List<ZoneData> zones;

  const ZonesLoadSuccess({required this.zones});
}

class ZonesLoadFailure extends ZoneFinderState {
  final String message;

  const ZonesLoadFailure({required this.message});
}

// ! Get Zone data by ID
