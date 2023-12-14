import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/title_text.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/zone_data.dart';
import '../bloc/zone_finder_bloc.dart';
import '../widgets/widgets.dart';

class ZoneFinderPage extends StatelessWidget {
  const ZoneFinderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: buildBody(context));
  }

  BlocProvider<ZoneFinderBloc> buildBody(BuildContext context) {
    List<ZoneData> zonesFound = [];
    List<ZoneData> zonesActive = [];

    return BlocProvider(
      create: (_) => sl<ZoneFinderBloc>(),
      child: BlocBuilder<ZoneFinderBloc, ZoneFinderState>(
        builder: (context, state) {
          if (state is ZoneFinderInitial) {
            // ! COMMENT FOR TESTING PURPOSES
            BlocProvider.of<ZoneFinderBloc>(context).add(GetAllZonesEvent());
          }
          if (state is ZonesLoadSuccess) {
            // TODO order zones
            zonesFound = state.zones;
            //zonesActive = state.zones;
          }
          return CustomScrollView(
            slivers: <Widget>[
              const SliverToBoxAdapter(
                child: TitleText(
                  title: 'Zona activa',
                  iconData: Icons.notifications,
                  verticalPadding: 16.0,
                  horizontalPadding: 16.0,
                ),
              ),
              if (state is ZonesLoadSuccess) ...[
                _activeZoneCardList(zonesActive),
              ] else if (state is ZonesLoadFailure) ...[
                // TODO implement failure
              ] else ...[
                _sliverCircularProgressIndicator(),
              ],
              const SliverToBoxAdapter(
                child: TitleText(
                  title: 'Zonas encontradas',
                  iconData: Icons.search,
                  verticalPadding: 16.0,
                  horizontalPadding: 16.0,
                ),
              ),
              if (state is ZonesLoadSuccess) ...[
                _zoneFoundCardList(zonesFound),
              ] else if (state is ZonesLoadFailure) ...[
                // TODO implement failure
              ] else ...[
                _sliverCircularProgressIndicator(),
              ]
            ],
          );
        },
      ),
    );
  }

  Widget _activeZoneCardList(List<ZoneData> zonesActive) {
    if (zonesActive.isEmpty) {
      return const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 36.0),
          child: Center(
            child: Text('No hay zonas activas'),
          ),
        ),
      );
    } else {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return ActiveZoneCard(
                context: context,
                title: zonesActive[index].zoneName,
                subtitle: zonesActive[index].zoneDescription);
          },
          childCount: zonesActive.length,
        ),
      );
    }
  }

  SliverToBoxAdapter _sliverCircularProgressIndicator() {
    return const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 36.0),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _zoneFoundCardList(List<ZoneData> zonesFound) {
    if (zonesFound.isEmpty) {
      return const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 36.0),
          child: Center(
            child: Text('No hay zonas encontradas'),
          ),
        ),
      );
    } else {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return ZoneFoundCard(
              zoneName: zonesFound[index].zoneName,
              zoneDescription: zonesFound[index].zoneDescription ?? '',
              context: context,
            );
          },
          childCount: zonesFound.length,
        ),
      );
    }
  }
}
