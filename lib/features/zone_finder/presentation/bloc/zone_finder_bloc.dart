import 'package:bloc/bloc.dart';
import 'package:botanic_visit_guide/features/zone_finder/domain/usecases/get_zone_data.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/zone_data.dart';
import '../../domain/usecases/get_all_zones_data.dart';

part 'zone_finder_event.dart';
part 'zone_finder_state.dart';

class ZoneFinderBloc extends Bloc<ZoneFinderEvent, ZoneFinderState> {
  final GetAllZonesData getAllZonesData;
  final GetZoneData
   getZoneData;

  ZoneFinderBloc({
    required this.getAllZonesData,
    required this.getZoneData,
  }) : super(ZoneFinderInitial()) {
    on<GetAllZonesEvent>((event, emit) async {
      emit(ZonesLoading());
      final result = await getAllZonesData(NoParams());
      result.fold(
          (failure) =>
              emit(const ZonesLoadFailure(message: cacheFailureMessage)),
          (zones) => emit(ZonesLoadSuccess(zones: zones)));
    });

    on<GetZoneDataEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
