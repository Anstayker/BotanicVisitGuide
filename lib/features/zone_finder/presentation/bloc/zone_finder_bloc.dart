import 'package:bloc/bloc.dart';
import 'package:botanic_visit_guide/features/zone_finder/domain/usecases/get_zone_data.dart';
import 'package:botanic_visit_guide/features/zone_finder/presentation/utils/zone_finder_gps_utils.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/zone_data.dart';
import '../../domain/usecases/get_all_zones_data.dart';

part 'zone_finder_event.dart';
part 'zone_finder_state.dart';

class ZoneFinderBloc extends Bloc<ZoneFinderEvent, ZoneFinderState> {
  final GetAllZonesData getAllZonesData;
  final GetZoneData getZoneData;
  final ZoneFinderGPSUtils gpsUtils;

  ZoneFinderBloc({
    required this.getAllZonesData,
    required this.getZoneData,
    required this.gpsUtils,
  }) : super(ZoneFinderInitial()) {
    on<GetAllZonesEvent>((event, emit) async {
      emit(ZonesLoading());

      final result = await getAllZonesData(NoParams());
      await result.fold(
          (failure) async =>
              emit(const ZonesLoadFailure(message: cacheFailureMessage)),
          (zones) async {
        final zonesActive = await gpsUtils.getActiveZones(zones);
        final zonesFound = await gpsUtils.getFoundZones(zones);

        emit(ZonesLoadSuccess(
            zones: zones, zonesActive: zonesActive, zonesFound: zonesFound));
      });
    });

    on<GetZoneDataEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
