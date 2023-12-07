import 'package:botanic_visit_guide/features/zone_creator/domain/entities/waypoint.dart';
import 'package:botanic_visit_guide/features/zone_creator/presentation/widgets/zone_creator_title.dart';
import 'package:flutter/material.dart';

class ZoneCreatorPage extends StatefulWidget {
  const ZoneCreatorPage({super.key});

  @override
  State<ZoneCreatorPage> createState() => _ZoneCreatorPageState();
}

class _ZoneCreatorPageState extends State<ZoneCreatorPage> {
  final ScrollController _scrollController = ScrollController();
  bool _isExpanded = false;
  final _formKey = GlobalKey<FormState>();
  List<Waypoint> _waypointsList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Creador de Zonas'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              zoneCreatorForm(),
            ],
          ),
        ));
  }

  Widget zoneCreatorForm() {
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
            _zoneNameTextField(),
            const ZoneCreatorTitle(
              title: 'Añadir punto de referencia *',
              verticalPadding: 16.0,
            ),
            _addNewZoneButton(),
            _formSizedBox(),
            _waypointsListView(),
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
            _createZoneButton()
          ],
        ),
      ),
    );
  }

  Widget _waypointsListView() {
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
          body: SizedBox(
            height: 225,
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _waypointsList.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    List<Waypoint> newList = List.from(_waypointsList);
                    newList.removeAt(index);
                    newList = newList.asMap().entries.map((entry) {
                      int newIndex = entry.key;
                      Waypoint oldWaypoint = entry.value;
                      return Waypoint(
                        waypointId: newIndex + 1,
                        latitude: oldWaypoint.latitude,
                        longitude: oldWaypoint.longitude,
                      );
                    }).toList();

                    setState(() {
                      _waypointsList = newList;
                    });
                  },
                  child: Card(
                    child: ListTile(
                      title:
                          Text('Posición ${_waypointsList[index].waypointId}'),
                      subtitle: Text(
                          'Latitud: ${_waypointsList[index].latitude} - Longitud: ${_waypointsList[index].longitude}'),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  FractionallySizedBox _createZoneButton() {
    return FractionallySizedBox(
      widthFactor: 1,
      child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              if (_waypointsList.length < 3) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text(
                          'Deben haber al menos 3 puntos de referencia en la lista')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Creando Zona')),
                );
              }
            }
          },
          child: const Text('Crear Zona')),
    );
  }

  ElevatedButton _addNewZoneButton() {
    return ElevatedButton(
        onPressed: () async {
          setState(() {
            _waypointsList.add(Waypoint(
                waypointId: _waypointsList.length + 1,
                latitude: 1.0,
                longitude: 1.0));
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
        },
        child: const Row(
          children: [
            Icon(Icons.add),
            Text('Add new zone'),
          ],
        ));
  }

  TextFormField _zoneNameTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Zone Name',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'El nombre de la zona no puede ser vacio';
        }
        return null;
      },
    );
  }

  _formSizedBox() {
    return const SizedBox(height: 16.0);
  }
}
