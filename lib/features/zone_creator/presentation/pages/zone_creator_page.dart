import 'package:flutter/material.dart';

import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/services/gps_service.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/waypoint_info.dart';
import '../../domain/entities/zone_info.dart';
import '../bloc/bloc.dart';
import '../widgets/widgets.dart';

import 'zone_visualizer_page.dart';

class ZoneCreatorPage extends StatefulWidget {
  const ZoneCreatorPage({super.key});

  @override
  State<ZoneCreatorPage> createState() => _ZoneCreatorPageState();
}

class _ZoneCreatorPageState extends State<ZoneCreatorPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _zoneNameController = TextEditingController();
  bool _isExpanded = false;
  final _formKey = GlobalKey<FormState>();
  List<WaypointInfo> _waypointsList = [];
  bool _isFormActive = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => _isFormActive,
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Creador de Zonas'),
          ),
          body: buildBody(context)),
    );
  }

  BlocProvider<ZoneCreatorBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ZoneCreatorBloc>(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<ZoneCreatorBloc, ZoneCreatorState>(
              builder: (context, state) {
                if (state is ZoneCreatorInitial) {
                  return _zoneCreatorForm();
                } else if (state is ZoneAddSubmiting) {
                  _isFormActive = false;
                } else if (state is ZoneAddSuccess) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Nueva zona creada exitosamente')),
                    );
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const ZoneVisualizerPage()),
                        (Route<dynamic> route) => false);
                  });
                } else if (state is ZoneAddFailure) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _showAddFailureDialog(context, state);
                  });
                }
                return _zoneCreatorForm();
              },
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> _showAddFailureDialog(
      BuildContext context, ZoneAddFailure state) {
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(state.message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Ok'),
              )
            ],
          );
        });
  }

  Widget _zoneCreatorForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const ZoneCreatorTitle(
              title: 'Crear una nueva zona *',
              verticalPadding: 16.0,
            ),
            ZoneNameTextField(
                isFormActive: _isFormActive,
                zoneNameController: _zoneNameController,
                onSaved: (value) {}),
            const ZoneCreatorTitle(
              title: 'Añadir punto de referencia *',
              verticalPadding: 16.0,
            ),
            _addNewZoneButton(),
            _formSizedBox(),
            _waypointsExpansionPanel(),
            _formSizedBox(),
            const ZoneCreatorTitle(
              title: 'Añadir Audio',
              verticalPadding: 16.0,
            ),
            const ZoneCreatorTitle(
              title: 'Añadir Imagenes',
              verticalPadding: 16.0,
            ),
            _formSizedBox(),
            CreateZoneButton(
                formKey: _formKey,
                context: context,
                isFormActive: _isFormActive,
                newZone: ZoneInfo(
                  // TODO cambiar a id
                  zoneId: '1',
                  name: _zoneNameController.text,
                  waypoints: _waypointsList,
                )),
          ],
        ),
      ),
    );
  }

  Widget _waypointsExpansionPanel() {
    return ExpansionPanelList(
      expansionCallback: (panelIndex, isExpanded) {
        setState(() {
          _isExpanded = !isExpanded;
        });
      },
      children: [
        ExpansionPanel(
          headerBuilder: (context, isExpanded) {
            return GestureDetector(
              onTap: () => setState(() => _isExpanded = !_isExpanded),
              child: const ListTile(
                title: Text('Waypoints'),
              ),
            );
          },
          isExpanded: _isExpanded,
          body: _waypointsListView(),
        ),
      ],
    );
  }

  SizedBox _waypointsListView() {
    return SizedBox(
      height: 225,
      child: ListView.builder(
        controller: _scrollController,
        itemCount: _waypointsList.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: UniqueKey(),
            onDismissed: (direction) {
              List<WaypointInfo> newList = List.from(_waypointsList);
              newList.removeAt(index);
              newList = newList.asMap().entries.map((entry) {
                int newIndex = entry.key;
                WaypointInfo oldWaypoint = entry.value;
                return WaypointInfo(
                  waypointId: "${newIndex + 1}",
                  latitude: oldWaypoint.latitude,
                  longitude: oldWaypoint.longitude,
                );
              }).toList();

              setState(() {
                _waypointsList = newList;
              });
            },
            child: WaypointsCard(waypointsList: _waypointsList, index: index),
          );
        },
      ),
    );
  }

  ElevatedButton _addNewZoneButton() {
    return ElevatedButton(
        onPressed: _isFormActive
            ? () async {
                setState(() {
                  _isFormActive = false;
                });
                dartz.Either<Failure, Position> position =
                    await sl<GpsService>().currentPosition;
                position.fold(
                    // TODO implement error message
                    (l) => print('error'),
                    (r) => _waypointsList.add(WaypointInfo(
                        waypointId: "${_waypointsList.length + 1}",
                        latitude: r.latitude,
                        longitude: r.longitude)));

                setState(() {
                  _isFormActive = true;
                  _isExpanded = true;
                });
                if (_isExpanded) {
                  await Future.delayed(const Duration(milliseconds: 100));
                  _scrollController.animateTo(
                    _scrollController.position.maxScrollExtent,
                    duration: const Duration(seconds: 1),
                    curve: Curves.fastOutSlowIn,
                  );
                }
              }
            : null,
        child: const Row(
          children: [
            Icon(Icons.add),
            Text('Add new zone'),
          ],
        ));
  }

  _formSizedBox() {
    return const SizedBox(height: 16.0);
  }
}
