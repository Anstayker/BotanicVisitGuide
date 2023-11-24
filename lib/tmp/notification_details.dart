import 'package:flutter/material.dart';

class NotificationDetailsPage extends StatefulWidget {
  const NotificationDetailsPage({super.key});

  @override
  State<NotificationDetailsPage> createState() =>
      _NotificationDetailsPageState();
}

class _NotificationDetailsPageState extends State<NotificationDetailsPage> {
  var _currentSliderValue = 0.0;

  @override
  Widget build(BuildContext context) {
    final List<IconData> icons = [
      Icons.forest,
      Icons.forest_rounded,
      Icons.forest_outlined,
    ];

    final List<Color> colors = [
      Colors.green,
      Colors.blue,
      Colors.red,
    ];

    const String notificationLongText =
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.';

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: null,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          imagenCarusel(icons, colors),
          Expanded(
              child: SingleChildScrollView(
                  child: notificationDescription(notificationLongText)))
        ],
      ),
      bottomNavigationBar: bottomAppBar(),
    );
  }

  Widget bottomAppBar() {
    return BottomAppBar(
      color: Colors.black,
      child: SizedBox(
        height: 64.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              reproducerText('00:00'),
              Expanded(
                child: Slider(
                  activeColor: Colors.white,
                  inactiveColor: Colors.grey,
                  value: _currentSliderValue,
                  min: 0,
                  max: 100,
                  onChanged: (double value) {
                    setState(() {
                      _currentSliderValue = value;
                    });
                  },
                ),
              ),
              reproducerText('03:30'),
              IconButton(
                icon: const Icon(Icons.pause, color: Colors.white),
                onPressed: () {
                  // Acción al presionar el botón
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget reproducerText(String text) {
    return Text(text, style: const TextStyle(color: Colors.white));
  }

  Widget notificationDescription(String longText) {
    return Column(
      children: [
        notificationTitle(),
        textoMuyLargo(longText),
        textoMuyLargo(longText),
      ],
    );
  }

  Widget textoMuyLargo(String longText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Text(
        longText,
        style: const TextStyle(fontSize: 16),
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget notificationTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nombre de la zona',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                'Nombre de la planta',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          FloatingActionButton(
            onPressed: () {
              // Acción al presionar el botón
            }, // Icono del botón
            backgroundColor: Colors.black,
            child: const Icon(Icons.play_arrow), // Color del botón
          ),
        ],
      ),
    );
  }

  Widget imagenCarusel(List<IconData> icons, List<Color> colors) {
    return Expanded(
      child: Container(
        color: Colors.grey[100],
        child: PageView.builder(
          itemCount: icons.length,
          itemBuilder: (context, index) {
            return Center(
              child: Icon(
                icons[index],
                size: 200,
                color: colors[index], // C
              ),
            );
          },
        ),
      ),
    );
  }
}
