import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../bloc/bloc.dart';
import '../widgets/zone_creator_title.dart';

import 'zone_creator_page.dart';

class ZoneVisualizerPage extends StatelessWidget {
  const ZoneVisualizerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Visualizador de Zonas'),
      // ),
      body: buildBody(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ZoneCreatorPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  BlocProvider<ZoneCreatorBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ZoneCreatorBloc>(),
      child: Column(
        children: [
          const ZoneCreatorTitle(
            title: 'Zonas disponibles',
            iconData: Icons.location_on,
            horizontalPadding: 16.0,
            verticalPadding: 16.0,
          ),
          BlocBuilder<ZoneCreatorBloc, ZoneCreatorState>(
            builder: (context, state) {
              if (state is ZoneCreatorInitial) {
                BlocProvider.of<ZoneCreatorBloc>(context)
                    .add(GetAllZonesEvent());
              } else if (state is ZoneLoading) {
                return const CircularProgressIndicator();
              } else if (state is ZoneLoadSuccess) {
                return Expanded(
                  child: ListView.builder(
                      itemCount: state.zones.length,
                      itemBuilder: (context, index) {
                        return Card(
                          // TODO Color should be in theme data
                          color: Colors.grey[100],
                          child: ExpansionTile(
                            title: Text(state.zones[index].name),
                            //subtitle: Text('${state.zones[index].zoneId}'),
                            children: state.zones[index].waypoints
                                .map((waypoint) => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            'Wayppoint: ${waypoint.waypointId}'),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8.0),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                                'Latitud: ${waypoint.latitude}'),
                                            Text(
                                                'Loingutd: ${waypoint.longitude}'),
                                          ],
                                        ),
                                      ],
                                    ))
                                .toList(),
                          ),
                        );
                      }),
                );
              } else if (state is ZoneLoadFailure) {
                return Text(state.message);
              }
              return const Text('data');
            },
          )
        ],
      ),
    );
  }
}
