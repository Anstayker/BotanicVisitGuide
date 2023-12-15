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
  final List<ZoneData> zonesFound;
  final List<ZoneData> zonesActive;

  const ZonesLoadSuccess(
      {required this.zones,
      required this.zonesFound,
      required this.zonesActive});
}

class ZonesLoadFailure extends ZoneFinderState {
  final String message;

  const ZonesLoadFailure({required this.message});
}

// ! Get Zone images by ID

class ZoneImagesLoading extends ZoneFinderState {}

class ZoneImagesLoadSuccess extends ZoneFinderState {
  final List<String> images;
  final String audio;

  const ZoneImagesLoadSuccess({required this.images, required this.audio});
}

class ZoneImagesLoadFailure extends ZoneFinderState {
  final String message;

  const ZoneImagesLoadFailure({required this.message});
}

// ! Get Zone data by ID
