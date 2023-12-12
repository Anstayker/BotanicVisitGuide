import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/title_text.dart';
import '../../../../injection_container.dart';
import '../bloc/zone_finder_bloc.dart';
import '../widgets/widgets.dart';

class ZoneFinderPage extends StatelessWidget {
  const ZoneFinderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: buildBody(context));
  }

  BlocProvider<ZoneFinderBloc> buildBody(BuildContext context) {
    return BlocProvider<ZoneFinderBloc>(
      create: (_) => sl<ZoneFinderBloc>(),
      child: CustomScrollView(
        slivers: <Widget>[
          const SliverToBoxAdapter(
            child:
                TitleText(title: 'Zona activa', iconData: Icons.notifications),
          ),
          _activeZoneCardList(),
          const SliverToBoxAdapter(
            child:
                TitleText(title: 'Zonas encontradas', iconData: Icons.search),
          ),
          _zoneFoundCardList(),
        ],
      ),
    );
  }

  SliverList _zoneFoundCardList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return ZoneFoundCard(
            zoneName: 'zoneName',
            zoneDescription: 'zoneDescription',
            context: context,
          );
        },
        childCount: 100,
      ),
    );
  }

  SliverList _activeZoneCardList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return ActiveZoneCard(context: context);
        },
        childCount: 2,
      ),
    );
  }
}
