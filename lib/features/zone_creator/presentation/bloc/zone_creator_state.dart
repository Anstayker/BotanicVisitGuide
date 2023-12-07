part of 'zone_creator_bloc.dart';

sealed class ZoneCreatorState extends Equatable {
  const ZoneCreatorState();

  @override
  List<Object> get props => [];
}

class ZoneCreatorInitial extends ZoneCreatorState {}

// ! Get Zones
class ZoneLoading extends ZoneCreatorState {}

class ZoneLoadSuccess extends ZoneCreatorState {
  final List<ZoneInfo> zones;

  const ZoneLoadSuccess({required this.zones});
}

class ZoneLoadFailure extends ZoneCreatorState {
  final String message;

  const ZoneLoadFailure({required this.message});
}

// ! Add new Zone
//class ZoneAddWaiting extends ZoneCreatorState {}

class ZoneAddSubmiting extends ZoneCreatorState {}

class ZoneAddSuccess extends ZoneCreatorState {}

class ZoneAddFailure extends ZoneCreatorState {
  final String message;

  const ZoneAddFailure({required this.message});
}
