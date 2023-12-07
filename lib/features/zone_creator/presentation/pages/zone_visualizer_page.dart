import 'package:botanic_visit_guide/features/zone_creator/presentation/bloc/bloc.dart';
import 'package:botanic_visit_guide/features/zone_creator/presentation/widgets/zone_creator_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import 'zone_creator_page.dart';

class ZoneVisualizerPage extends StatelessWidget {
  const ZoneVisualizerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zone Visualizer'),
      ),
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
      child: ListView(
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
                return const Text('data');
              }
              return const Text('data 2');
            },
          )
        ],
      ),
    );
  }
}
