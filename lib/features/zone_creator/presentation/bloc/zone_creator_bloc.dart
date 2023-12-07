import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/zone_info.dart';
import '../../domain/usecases/add_zone.dart';
import '../../domain/usecases/get_all_zones.dart';

part 'zone_creator_event.dart';
part 'zone_creator_state.dart';

const String cacheFailureMessage = 'Cache Failure';

class ZoneCreatorBloc extends Bloc<ZoneCreatorEvent, ZoneCreatorState> {
  final AddZone addZone;
  final GetAllZones getAllZones;

  ZoneCreatorBloc({
    required this.addZone,
    required this.getAllZones,
  }) : super(ZoneCreatorInitial()) {
    on<GetAllZonesEvent>((event, emit) async {
      emit(ZoneLoading());
      final result = await getAllZones(NoParams());
      result.fold(
          (failure) =>
              emit(const ZoneLoadFailure(message: cacheFailureMessage)),
          (zones) => emit(ZoneLoadSuccess(zones: zones)));
    });

    on<AddZoneEvent>((event, emit) async {
      emit(ZoneAddSubmiting());
      final result = await addZone(Params(zone: event.zone));
      result
          .fold((failure) => const ZoneAddFailure(message: cacheFailureMessage),
              (_) async {
        emit(ZoneAddSuccess());
      });
    });
  }
}
